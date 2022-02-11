import SwiftUI

struct MovieSearchScreen: View {
    
    @ObservedObject var movieListScreenViewModel: MovieListScreenViewModel
    @State var searchTerm: String = ""
    internal var didAppear: ((Self) -> Void)?
    /* NOTE:
     when testing @State, @Binding, etc ViewInspector uses the didAppear() method to gain access to values.
     See MovieSearchScreenSpec for implementation
     */
    init(withMovieListScreenViewModel model: MovieListScreenViewModel = MovieListScreenViewModel()) {
        movieListScreenViewModel = model
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Enter a Movie")
                TextField("Movie Title", text: $searchTerm, onCommit: {
                    if searchTerm.count > 0 {
                        movieListScreenViewModel.getMovies(forSearchTerm: searchTerm)
                    }
                })
                    .padding()
                    .border(Color(.black), width: 2.0)
                    .id("searchField")
            }
            .id("searchHolder")
            
            MovieListView(withMovieListScreenViewModel: movieListScreenViewModel)
        }
        .padding()
        .navigationTitle("Movies")
        .onAppear {
            self.didAppear?(self)
        }
        .id("mainVStack")
    }
}

#if !TESTING
struct MovieListScreen_Previews: PreviewProvider {
    static var previews: some View {
        let movieListScreenViewModel = MovieListScreenViewModel()
        movieListScreenViewModel.movies = [
            MovieViewModel(withMovie: Movie(title: "Batman Begins", year: "2005", imdbId: "tt0372784", type: "movie", posterUrl: "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg")),
            MovieViewModel(withMovie: Movie(title: "Batman Begins", year: "2005", imdbId: "tt0372784", type: "movie", posterUrl: "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg")),
            MovieViewModel(withMovie: Movie(title: "Batman Begins", year: "2005", imdbId: "tt0372784", type: "movie", posterUrl: "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg")),
            MovieViewModel(withMovie: Movie(title: "Batman Begins", year: "2005", imdbId: "tt0372784", type: "movie", posterUrl: "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg")),
            MovieViewModel(withMovie: Movie(title: "Batman Begins", year: "2005", imdbId: "tt0372784", type: "movie", posterUrl: "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg"))
        ]
        
        return MovieSearchScreen(withMovieListScreenViewModel: movieListScreenViewModel)
            
    }
}
#endif
