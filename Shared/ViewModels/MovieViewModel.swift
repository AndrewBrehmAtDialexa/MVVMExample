import SwiftUI

class MovieViewModel: ObservableObject {
    let movie: Movie
    let placeHolderImage = UIImage(systemName: "film")!// ?? UIImage()
    @Published var posterImage: UIImage
    var imdbMovieService = ImdbMovieService()
    
    
    init(withMovie movie: Movie) {
        self.movie = movie
        self.posterImage = placeHolderImage
    }
    
    var title: String {
        movie.title
    }
    
    var year: String {
        movie.year
    }
    
    var imdbId: String {
        movie.imdbId
    }
    
    var posterUrl: String {
        movie.posterUrl
    }
    
    var posterImagePadding: EdgeInsets {
        let padding: CGFloat = (posterImage == placeHolderImage ? 25 : 0)
        return EdgeInsets(top: padding * 2, leading: padding, bottom: padding * 2, trailing: padding)
    }
    
    func getPosterImage() {
        imdbMovieService.getPosterImage(forUrlString: posterUrl) { result in
            switch result {
            case.success(let imageResult):
                DispatchQueue.main.async {
                    self.posterImage = imageResult
                }
            case.failure(let imageError):
                print("Image Error: ", imageError)
            }
        }
    }
}
