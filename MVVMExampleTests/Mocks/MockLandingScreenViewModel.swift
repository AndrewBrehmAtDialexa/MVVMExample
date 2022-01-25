import Foundation
@testable import MVVMExample

class MockLandingScreenViewModel: LandingScreenViewModel {
    
    var buttonATappedWasCalled = false
    var buttonBTappedWasCalled = false
    var navLinkADestinationWasCalled = false
    
    override func buttonATapped() {
        buttonATappedWasCalled = true
    }
    
    override func buttonBTapped() {
        buttonBTappedWasCalled = true
    }
    
    override func navLinkADestination() -> MovieListScreen {
        navLinkADestinationWasCalled = true
        
        return MovieListScreen()
    }
}
