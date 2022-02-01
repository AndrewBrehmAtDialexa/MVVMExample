import SnapshotTesting
import XCTest
import SwiftUI
@testable import MVVMExample

class MovieSearchScreenSnapshotTest: BaseSnapshotTest {
    func testMovieSearchScreen() {
//        let uut = MovieSearchScreen()
        let uut = UIHostingController<MovieSearchScreen>(rootView:MovieSearchScreen())
        
//        assertSnapshot(matching: uut, as: .image)
        takeSnapshot(for: uut)
    }
}
