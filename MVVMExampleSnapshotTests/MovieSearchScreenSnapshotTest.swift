import SnapshotTesting
import XCTest
@testable import MVVMExample

class MovieSearchScreenSnapshotTest: BaseSnapshotTest {
    func testMovieSearchScreen() {
        let uut = MovieSearchScreen()
        
        
        assertSnapshot(matching: uut, as: .image)
    }
}
