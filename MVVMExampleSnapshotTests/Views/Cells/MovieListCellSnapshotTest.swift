import SnapshotTesting
import XCTest
import SwiftUI
@testable import MVVMExample

class MovieListCellSnapshotTest: BaseSnapshotTest {
    func testMovieListCell() {
        let stub = StubData()
        stub.addMockUrl(forUrl: "somePosterUrl", fromResource: "posterImage", withExtension: "jpg")
        stub.create()
        
        let mockMovie = MockMovie.create() 
        let movieListCell = MovieListCell(withMovieViewModel: MovieViewModel(movie: mockMovie))
        
        let uut = UIHostingController<MovieListCell>(rootView: movieListCell)
        
        takeSnapshot(for: uut, clipToComponent: true)
    }
}


/*
 
 With Dummy -> imges appear
 without dummy -> images appear / one image always blank
 
 WO dummy / timeout 5 / wait 0 -> IBID
 WO dummy / timeout 5 / wait 5 -> IBID
 
 WO dummy / timeout 5 / NO wait ->
 
 */
