import SwiftUI

struct MovieListView: View {
    
    @ObservedObject var movieListScreenViewModel: MovieListScreenViewModel
    
    init(withMovieListScreenViewModel viewModel: MovieListScreenViewModel) {
        self.movieListScreenViewModel = viewModel
        print("TEST: MovieListView init")
    }
    
    var body: some View {
        List {
            ForEach(movieListScreenViewModel.movies, id:\.imdbId) { movieViewModel in
                MovieListCell(withMovieViewModel: movieViewModel)
                    .id(movieViewModel.imdbId)
            }
            .listRowBackground(Color.white)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))
        }
        .listStyle(PlainListStyle())
        .id("movieList")
    }
}

#if !TESTING
struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        let movieListScreenViewModel = MovieListScreenViewModel()
        movieListScreenViewModel.movies = [
            MovieViewModel(withMovie: Movie(title: "Batman Begins", year: "2005", imdbId: "tt0372784", type: "movie", posterUrl: "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg")),
            MovieViewModel(withMovie: Movie(title: "Batman Begins", year: "2005", imdbId: "tt0372784", type: "movie", posterUrl: "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg")),
            MovieViewModel(withMovie: Movie(title: "Batman Begins", year: "2005", imdbId: "tt0372784", type: "movie", posterUrl: "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg")),
            MovieViewModel(withMovie: Movie(title: "Batman Begins", year: "2005", imdbId: "tt0372784", type: "movie", posterUrl: "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg"))
            ,MovieViewModel(withMovie: Movie(title: "Batman Begins", year: "2005", imdbId: "tt0372784", type: "movie", posterUrl: "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg"))
        ]
        
        return MovieListView(withMovieListScreenViewModel: movieListScreenViewModel)
    }
}
#endif
