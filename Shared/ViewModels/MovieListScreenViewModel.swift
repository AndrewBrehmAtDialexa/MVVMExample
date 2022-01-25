import SwiftUI

class MovieListScreenViewModel: ObservableObject {
    
    @Published var movies = [MovieViewModel]() 
    
    var imdbMovieService = ImdbMovieService()
    
    func getMovies() {
        imdbMovieService.getMovies(bySearchTerm: "batman") { result in
            switch result {
            case.success(let moviesResult):
                if let moviesResult = moviesResult {
                    DispatchQueue.main.async {
                        self.movies = moviesResult.map(MovieViewModel.init)
                    }
                }
            case.failure(let error):
                //present Alert
                print("ERROR", error)
            }
        }
    }
}
