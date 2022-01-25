import SwiftUI

struct MovieListScreen: View {
    
    @ObservedObject var movieListScreenViewModel = MovieListScreenViewModel()
    
    var body: some View {
        VStack {
            List(movieListScreenViewModel.movies, id:\.imdbId) { movie in
                HStack {
                    AsyncImage(
                        url: URL(string: movie.posterUrl),
                        content: { image in
                            image
                                .resizable()
                                .frame(width: 100, height: 150, alignment: .leading)
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(5.0)
                        },
                        placeholder: {
                            Image(systemName: "film")
                                .resizable()
                                .frame(width: 100, height: 150, alignment: .leading)
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(5.0)
                        }
                    )
                    VStack(alignment: .leading) {
                        Text(movie.title)
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                        Text(movie.year)
                            .font(.system(size: 12))
                    }
                    Spacer()
                }
                .background(Color(.lightGray))
                
            }
        }
        .onAppear(perform: {
            movieListScreenViewModel.getMovies()
        })
        .navigationTitle("Movies")
    }
}

#if !TESTING
struct MovieListScreen_Previews: PreviewProvider {
    static var previews: some View {
        let movieListScreen = MovieListScreen()
        movieListScreen.movieListScreenViewModel.movies = [
            MovieViewModel(movie: Movie(title: "Batman Begins", year: "2005", imdbId: "tt0372784", type: "movie", posterUrl: "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg"))
        ]
        
        return movieListScreen
    }
}
#endif
