import SnapshotTesting
import XCTest
@testable import MVVMExample

class LandingScreenSnapshotTest: BaseSnapshotTest {
    func testLandingScreen() {
        let uut = LandingScreen()
        
        
        assertSnapshot(matching: uut, as: .image)
    }
}
