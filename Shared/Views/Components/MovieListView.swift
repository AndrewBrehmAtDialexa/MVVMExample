import SwiftUI

struct MovieListView: View {
    
    @ObservedObject var movieListScreenViewModel: MovieListScreenViewModel
    
    init(withMovieListScreenViewModel viewModel: MovieListScreenViewModel) {
        self.movieListScreenViewModel = viewModel
    }
    
    var body: some View {
        List(movieListScreenViewModel.movies, id:\.imdbId) { movieViewModel in
            MovieListCell(withMovieViewModel: movieViewModel)
                .id(movieViewModel.imdbId)
        }
        .id("movieList")
    }
}

#if !TESTING
struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        let movieListScreenViewModel = MovieListScreenViewModel()
        movieListScreenViewModel.movies = [
            MovieViewModel(movie: Movie(title: "Batman Begins", year: "2005", imdbId: "tt0372784", type: "movie", posterUrl: "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg")),
            MovieViewModel(movie: Movie(title: "Batman Begins", year: "2005", imdbId: "tt0372784", type: "movie", posterUrl: "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg")),
            MovieViewModel(movie: Movie(title: "Batman Begins", year: "2005", imdbId: "tt0372784", type: "movie", posterUrl: "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg")),
            MovieViewModel(movie: Movie(title: "Batman Begins", year: "2005", imdbId: "tt0372784", type: "movie", posterUrl: "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg"))
            ,MovieViewModel(movie: Movie(title: "Batman Begins", year: "2005", imdbId: "tt0372784", type: "movie", posterUrl: "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg"))
        ]
        
        return MovieListView(withMovieListScreenViewModel: movieListScreenViewModel)
    }
}
#endif
