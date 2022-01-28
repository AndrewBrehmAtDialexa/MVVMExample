import SwiftUI

struct MovieListCell: View {
    private let movie: MovieViewModel
    
    init(withMovieViewModel viewModel: MovieViewModel) {
        self.movie = viewModel
    }
    
    var body: some View {
        HStack {
            AsyncImage(
                url: URL(string: movie.posterUrl),
                content: { image in
                    image
                        .resizable()
                        .id("poster")
                },
                placeholder: {
                    Image(systemName: "film")
                        .resizable()
                        .id("placeHolder")
                }
            )
                .frame(width: 100, height: 150, alignment: .leading)
                .aspectRatio(contentMode: .fill)
                .cornerRadius(5.0)
                .id("posterAsyncImage")

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
        .id("mainHStack")
        .background(Color(.lightGray))
    }
}

#if !TESTING
struct MovieListCell_Previews: PreviewProvider {
    static var previews: some View {
        MovieListCell(withMovieViewModel: MovieViewModel(movie: Movie(title: "Batman Begins", year: "2005", imdbId: "tt0372784", type: "movie", posterUrl: "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg")))
    }
}
#endif
