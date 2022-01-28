import SwiftUI

struct MovieSearchScreen: View {
    
    @ObservedObject var movieListScreenViewModel = MovieListScreenViewModel()
    @State var searchTerm: String = ""
    internal var didAppear: ((Self) -> Void)?
    /* NOTE:
     when testing @State, @Binding, etc ViewInspector uses the didAppear() method to gain access to values.
     See MovieSearchScreenSpec for implementation
     */
    
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
            .padding()
            .id("searchHolder")
            
            MovieListView(withMovieListScreenViewModel: movieListScreenViewModel)
        }
        .navigationTitle("Movies")
        .onAppear { self.didAppear?(self) }
        .id("mainVStack")
    }
}

#if !TESTING
struct MovieListScreen_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchScreen()
    }
}
#endif
