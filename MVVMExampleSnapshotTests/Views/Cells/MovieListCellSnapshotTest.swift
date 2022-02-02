import SnapshotTesting
import XCTest
import SwiftUI
@testable import MVVMExample

class MovieListCellSnapshotTest: BaseSnapshotTest {
    func testMovieListCell() {
        let uut = UIHostingController<MovieListCell>(rootView: MovieListCell(withMovieViewModel: MovieViewModel(movie: MockMovie.create())))
        
        takeSnapshot(for: uut, clipToComponent: true)
    }
}
