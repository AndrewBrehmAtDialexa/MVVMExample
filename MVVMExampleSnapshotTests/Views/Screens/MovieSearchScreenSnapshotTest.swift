import SnapshotTesting
import XCTest
import SwiftUI
@testable import MVVMExample

class MovieSearchScreenSnapshotTest: BaseSnapshotTest {     
    func testMovieSearchScreen() {
        let uut = UIHostingController<MovieSearchScreen>(rootView: MovieSearchScreen())
        takeSnapshot(for: uut, addToNavigationView: true)
    }
    
    func testListWithMoviesAndImages() {
        let stub = StubData()
        let url = URL.forOmdb(withSearchTerm: "batman")!.absoluteString
        stub.addMockUrl(forUrl: url, fromResource: "batmanStub", withExtension: "json")
        stub.create()
        
        let movieSearchScreen = MovieSearchScreen()
        movieSearchScreen.movieListScreenViewModel.getMovies(forSearchTerm: "batman")
        
        let moviesPopulatedExpectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "movieSearchScreen.movieListScreenViewModel.movies.count > 0"),
            object: movieSearchScreen)
        
        _ = XCTWaiter.wait(for: [moviesPopulatedExpectation],
                            timeout: 1, enforceOrder: true)
        
        let posterImage = stub.createImage(fromResource: "posterImage", withExtension: "jpg")
        for movie in movieSearchScreen.movieListScreenViewModel.movies {
            movie.posterImage = posterImage
        }
        
        let uut = UIHostingController<MovieSearchScreen>(rootView: movieSearchScreen)
        takeSnapshot(for: uut, addToNavigationView: true)
    }
    
    func testListWithMoviesAndNoImages() {
        let stub = StubData()
        let url = URL.forOmdb(withSearchTerm: "batman")!.absoluteString
        stub.addMockUrl(forUrl: url, fromResource: "batmanStub", withExtension: "json")
        stub.create()
        
        let movieSearchScreen = MovieSearchScreen()
        movieSearchScreen.movieListScreenViewModel.getMovies(forSearchTerm: "batman")
        
        let uut = UIHostingController<MovieSearchScreen>(rootView: movieSearchScreen)
        takeSnapshot(for: uut, addToNavigationView: true)
    }
}
