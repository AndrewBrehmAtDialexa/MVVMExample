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
        let stub = StubData()
        let url = URL.forOmdb(withSearchTerm: "batman")!.absoluteString
        stub.addMockUrl(forUrl: url, fromResource: "batmanStub", withExtension: "json")
        stub.addMockUrl(forUrl: "somePosterUrl", fromResource: "posterImage", withExtension: "jpg")
        stub.create()
        
        let movieSearchScreen = MovieSearchScreen()
        movieSearchScreen.movieListScreenViewModel.getMovies(forSearchTerm: "batman")
        
        let uut = UIHostingController<MovieSearchScreen>(rootView: movieSearchScreen)
        takeSnapshot(for: uut, addToNavigationView: true)
    }
}
