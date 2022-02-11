import SwiftUI

class MovieViewModel: ObservableObject {
    let movie: Movie
    @Published var posterImage: UIImage
    var imdbMovieService = ImdbMovieService()
    
    
    init(withMovie movie: Movie) {
        self.movie = movie
        self.posterImage = UIImage(systemName: "film") ?? UIImage()
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
