import Foundation
@testable import MVVMExample

class MockLandingScreenViewModel: LandingScreenViewModel {
    
    var buttonATappedWasCalled = false
    var buttonBTappedWasCalled = false
    
    override func buttonATapped() {
        buttonATappedWasCalled = true
    }
    
    override func buttonBTapped() {
        buttonBTappedWasCalled = true
    }
}
