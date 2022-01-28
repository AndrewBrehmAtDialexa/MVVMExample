import Quick
import Nimble
import SwiftUI
import Combine
@testable import MVVMExample

class LandingScreenViewModelSpec: QuickSpec {
    override func spec() {
        
        describe("LandingScreenViewModel") {
            var uut: LandingScreenViewModel?
            
            beforeEach {
                uut = LandingScreenViewModel()
            }
            
            // MARK: - @Published vars
            
            describe("@Published .buttonAText") {
                it("has a value of 'Blue Button'") {
                    expect(uut?.buttonAText).to(equal("Blue Button"))
                }
                
                describe("when .buttonAText changes") {
                    beforeEach {
                        uut?.buttonAText = "someText"
                    }
                    
                    it("publishes the change") {
                        let _ = uut?.$buttonAText.sink { publihedValue in
                            expect(publihedValue).to(equal("someText"))
                        }
                    }
                }
            }
            
            describe("@Published .buttonBText") {
                it("has a value of 'Red Button'") {
                    expect(uut?.buttonBText).to(equal("Red Button"))
                }
                
                describe("when .buttonBText changes") {
                    beforeEach {
                        uut?.buttonBText = "someText"
                    }
                    
                    it("publishes the change") {
                        let _ = uut?.$buttonBText.sink { publihedValue in
                            expect(publihedValue).to(equal("someText"))
                        }
                    }
                }
            }
            
            describe("@Published .buttonABackground") {
                it("has a value of Color(.blue)") {
                    expect(uut?.buttonABackground).to(equal(Color(.blue)))
                }
                
                describe("when .buttonABackground changes") {
                    beforeEach {
                        uut?.buttonABackground = .orange
                    }
                    
                    it("publishes the change") {
                        let _ = uut?.$buttonABackground.sink { publihedValue in
                            expect(publihedValue).to(equal(.orange))
                        }
                    }
                }
            }
            
            describe("@Published .buttonBBackground") {
                it("has a value of Color(.red)") {
                    expect(uut?.buttonBBackground).to(equal(Color(.red)))
                }
                
                describe("when .buttonBBackground changes") {
                    beforeEach {
                        uut?.buttonBBackground = .green
                    }
                    
                    it("publishes the change") {
                        let _ = uut?.$buttonBBackground.sink { publihedValue in
                            expect(publihedValue).to(equal(.green))
                        }
                    }
                }
            }
            
            // MARK: - Methods
            
            describe("when .buttonATapped()") {
                beforeEach {
                    uut?.buttonATapped()
                }
                
                it("sets .buttonAText to 'TAPPED A'") {
                    expect(uut?.buttonAText).toEventually(equal("TAPPED A"))
                }
                
                it("sets .buttonABackground to Color(.black)") {
                    expect(uut?.buttonABackground).toEventually(equal(.black))
                }
            }
            
            describe("when .buttonBTapped()") {
                beforeEach {
                    uut?.buttonBTapped()
                }
                
                it("sets .buttonBText to 'TAPPED B'") {
                    expect(uut?.buttonBText).toEventually(equal("TAPPED B"))
                }
                
                it("sets .buttonBBackground to Color(.yellow)") {
                    expect(uut?.buttonBBackground).toEventually(equal(.yellow))
                }
            }
            
            describe("when .navLinkADestination()") {
                var result: MovieSearchScreen?
                
                beforeEach {
                    result = uut?.navLinkADestination()
                }
                
                it("returns a IconDisplayScreen") {
                    expect(result).to(beAKindOf(MovieSearchScreen.self))
                }
            }
        }
    }
}
