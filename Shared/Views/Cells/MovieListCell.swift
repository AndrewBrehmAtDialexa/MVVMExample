import SwiftUI

struct MovieListCell: View {
    @ObservedObject private var movie: MovieViewModel
    
    init(withMovieViewModel viewModel: MovieViewModel) {
        self.movie = viewModel
        self.movie.getPosterImage()
    }
    
    var body: some View {
        HStack {
            Image(uiImage: movie.posterImage)
                .resizable()
                .padding(movie.posterImagePadding)
                .frame(width: 100, height: 150, alignment: .center)
                .aspectRatio(contentMode: .fit)
                .id("posterImage")

            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .id("movieTitleText")
                Text(movie.year)
                    .font(.system(size: 12))
                    .id("movieYearText")
            }
            .id("textHolderVStack")
            Spacer()
        }
        .background(Color(.lightGray))
        .cornerRadius(5.0)
        .id("mainHStack")
    }
}

#if !TESTING
struct MovieListCell_Previews: PreviewProvider {
    static var previews: some View {
        // With Poster Image
        MovieListCell(withMovieViewModel: MovieViewModel(withMovie: Movie(title: "Batman Begins", year: "2005", imdbId: "tt0372784", type: "movie", posterUrl: "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg")))
        
        // No Poster Image
        MovieListCell(withMovieViewModel: MovieViewModel(withMovie: Movie(title: "Batman Begins", year: "2005", imdbId: "tt0372784", type: "movie", posterUrl: "BadUrl")))
    }
}
#endif
