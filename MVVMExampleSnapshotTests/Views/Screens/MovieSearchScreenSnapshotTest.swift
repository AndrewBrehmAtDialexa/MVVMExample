import SnapshotTesting
import XCTest
import SwiftUI
@testable import MVVMExample

class MovieSearchScreenSnapshotTest: BaseSnapshotTest {    
    func testMovieSearchScreen() {
        let uut = UIHostingController<MovieSearchScreen>(rootView: MovieSearchScreen())
        takeSnapshot(for: uut, addToNavigationView: true)
    }
    
    func testListWithMovies() {
        let movieListScreenViewModel = MovieListScreenViewModel()
        movieListScreenViewModel.movies = [
            MovieViewModel(movie: MockMovie.create(withPlacement: "1")),
            MovieViewModel(movie: MockMovie.create(withPlacement: "2")),
            MovieViewModel(movie: MockMovie.create(withPlacement: "3"))
        ]
        let uut = UIHostingController<MovieSearchScreen>(rootView: MovieSearchScreen(withMovieListScreenViewModel: movieListScreenViewModel))
        
        takeSnapshot(for: uut, addToNavigationView: true)
    }
}
