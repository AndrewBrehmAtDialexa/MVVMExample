import SnapshotTesting
import XCTest
import SwiftUI
@testable import MVVMExample

class LandingScreenSnapshotTest: BaseSnapshotTest {
    func testLandingScreen() {
        let uut = UIHostingController<LandingScreen>(rootView:LandingScreen())
        
        
        takeSnapshot(for: uut)
    }
}
