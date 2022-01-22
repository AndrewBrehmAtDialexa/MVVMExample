//
//  MockLandingScreenViewModel.swift
//  TempProjTests
//
//  Created by Andrew Brehm on 1/20/22.
//

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
