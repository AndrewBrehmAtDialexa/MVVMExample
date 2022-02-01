import SnapshotTesting
import XCTest
import SwiftUI
@testable import MVVMExample

class LandingScreenSnapshotTest: BaseSnapshotTest {
    func testLandingScreen() {
        //let uut = LandingScreen()
        let uut = UIHostingController<LandingScreen>(rootView:LandingScreen())
        
        
        takeSnapshot(for: uut)
//        assertSnapshot(matching: uut, as: .image)
//        assertSnapshot(matching: <#T##Value#>, as: <#T##Snapshotting<Value, Format>#>)
//        assertSnapshot(matching: uut, as: .image(on: .iPhoneSe), named: "iPhoneSe")
//        assertSnapshot(matching: uut, as: .image(on: .iPhoneX))
    }
}
