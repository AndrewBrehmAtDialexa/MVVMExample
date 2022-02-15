import SwiftUI

class MovieListScreenViewModel: ObservableObject {
    
    @Published var movies = [MovieViewModel]()
    @Published var errorMessageToPresent: String?
    
    var imdbMovieService = ImdbMovieService()
    
    func getMovies(forSearchTerm search: String) {
        
        imdbMovieService.getMovies(bySearchTerm: search.encoded) { result in
            switch result {
            case.success(let moviesResult):
                if let moviesResult = moviesResult {
                    DispatchQueue.main.async {
                        self.movies = moviesResult.map(MovieViewModel.init)
                    }
                }
            case.failure(let movieError):
                DispatchQueue.main.async {
                    self.errorMessageToPresent = movieError.error
                }
            }
        }
    }
}
