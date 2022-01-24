import Quick
import Nimble
import SwiftUI
import ViewInspector
@testable import MVVMExample

class LandingScreenSpec: QuickSpec {
    override func spec() {
        
        describe("LandingScreen") {
            
            var uut: LandingScreen?
            var landingScreenViewModel: MockLandingScreenViewModel?
            
            beforeEach {
                uut = LandingScreen()
                landingScreenViewModel = MockLandingScreenViewModel()
                uut?.landingScreenViewModel = landingScreenViewModel!
            }
            
            describe("the body") {
                var navView: InspectableView<ViewType.NavigationView>?
                
                beforeEach {
                    navView = uut?.findNavView()
                }
                
                it("has a NavigationView with .id 'navView'") {
                    expect(navView).toNot(beNil())
                }
                
                describe("navView") {
                    var mainVStack: InspectableView<ViewType.VStack>?
                    
                    beforeEach {
                        mainVStack = navView?.findChild(type: ViewType.VStack.self, withId: "mainVStack")
                    }
                    
                    it("has a VStack with .id 'mainVStack'") {
                        expect(mainVStack).toNot(beNil())
                    }
                    
                    describe("mainVStack") {
                        var screenTextA: InspectableView<ViewType.Text>?
                        var screenTextB: InspectableView<ViewType.Text>?
                        var buttonHolder: InspectableView<ViewType.HStack>?
                        var navLinkA: InspectableView<ViewType.NavigationLink>?
                        
                        beforeEach {
                            screenTextA = mainVStack?.findChild(type: ViewType.Text.self, withId: "screenTextA")
                            //NOTE: without the View extension the code would be:
                            // try uut?.body.inspect().find(ViewType.Text.self, relation: .child, where: { try $0.id() as! String == "screenTextA"})
                            screenTextB = mainVStack?.findChild(type: ViewType.Text.self, withId: "screenTextB")
                            buttonHolder = mainVStack?.findChild(type: ViewType.HStack.self, withId: "buttonHolder")
                            navLinkA = mainVStack?.findNavLink("Display Icons")
                        }
                        
                        it("has a Text with .id 'screenTextA'") {
                            expect(screenTextA).toNot(beNil())
                        }
                        
                        describe("screenTextA") {
                            it("has text of 'First Text'") {
                                expect(try screenTextA?.string()).to(equal("First Text"))
                            }
                            
                            it("has .padding()") {
                                expect(screenTextA?.hasPadding()).to(beTrue())
                            }
                            
                            it("has .foregroundColor of .red") {
                                expect(try screenTextA?.attributes().foregroundColor()).to(equal(.red))
                            }
                        }
                        
                        it("has a Text with .id 'screenTextB'") {
                            expect(screenTextB).toNot(beNil())
                        }
                        
                        describe("screenTextB") {
                            it("has text of 'Second Text'") {
                                expect(try screenTextB?.string()).to(equal("Second Text"))
                            }
                            
                            it("has .padding() of EdgeInsets(top: 10, leading: 20, bottom: 30, trailing: 40)") {
                                expect(try screenTextB?.padding()).to(equal(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30)))
                            }
                        }
                        
                        it("has a HStack with .id 'buttonHolder'") {
                            expect(buttonHolder).toNot(beNil())
                        }
                        
                        describe("buttonHolder") {
                            var buttonA: InspectableView<ViewType.Button>?
                            var buttonB: InspectableView<ViewType.Button>?
                            
                            beforeEach {
                                buttonA = buttonHolder?.findChild(type: ViewType.Button.self, withId: "buttonA")
                                buttonB = buttonHolder?.findChild(type: ViewType.Button.self, withId: "buttonB")
                            }
                            
                            it("has .padding()") {
                                expect(buttonHolder?.hasPadding()).to(beTrue())
                            }
                            
                            it("has a button with .id 'buttonA'") {
                                expect(buttonA).toNot(beNil())
                            }
                            
                            describe("buttonA") {
                                var buttonLabelText: InspectableView<ViewType.Text>?
                                
                                beforeEach {
                                    do {
                                        buttonLabelText = try buttonA?.labelView().text()
                                    } catch {}
                                }
                                
                                describe("when tapped") {
                                    beforeEach {
                                        do {
                                            try buttonA?.tap()
                                        } catch {}
                                    }
                                    
                                    it("calls .landingScreenViewModel.buttonATapped()") {
                                        expect(landingScreenViewModel?.buttonATappedWasCalled).to(beTrue())
                                    }
                                }
                                
                                it("has a label with a Text") {
                                    expect(buttonLabelText).toNot(beNil())
                                }
                                
                                describe("that Text") {
                                    it("has a text value of 'Blue Button'") {
                                        expect(try buttonLabelText?.string()).to(equal("Blue Button"))
                                    }
                                    it("has .padding()") {
                                        expect(buttonLabelText?.hasPadding()).to(beTrue())
                                    }
                                    it("has a .foregroundColor of .white") {
                                        expect(try buttonLabelText?.attributes().foregroundColor()).to(equal(.white))
                                    }
                                }
                            }
                            
                            it("has a child with .id 'buttonB'") {
                                expect(buttonB).toNot(beNil())
                            }
                            
                            describe("buttonB") {
                                var buttonLabelText: InspectableView<ViewType.Text>?
                                
                                beforeEach {
                                    do {
                                        buttonLabelText = try buttonB?.labelView().text()
                                    } catch {}
                                }
                                
                                describe("when tapped") {
                                    beforeEach {
                                        do {
                                            try buttonB?.tap()
                                        } catch {}
                                    }
                                    
                                    it("calls .landingScreenViewModel.buttonBTapped()") {
                                        expect(landingScreenViewModel?.buttonBTappedWasCalled).to(beTrue())
                                    }
                                }
                                
                                it("has a label with a Text") {
                                    expect(buttonLabelText).toNot(beNil())
                                }
                                
                                describe("that Text") {
                                    it("has a text value of 'Red Button'") {
                                        expect(try buttonLabelText?.string()).to(equal("Red Button"))
                                    }
                                    it("has .padding()") {
                                        expect(buttonLabelText?.hasPadding()).to(beTrue())
                                    }
                                    it("has a .foregroundColor of .white") {
                                        expect(try buttonLabelText?.attributes().foregroundColor()).to(equal(.white))
                                    }
                                }
                            }
                        }
                        
                        it("has a NavigationLink with title of 'Display Icons'") {
                            expect(navLinkA).toNot(beNil())
                        }
                        
                        describe("that NavigationLink") {
                            it("has a .destination from .landingScreenViewModel.navLinkADestination()") {
                                expect(landingScreenViewModel?.navLinkADestinationWasCalled).to(beTrue())
                            }
                        }
                    }
                }
            }
            
            // MARK: - Methods
            
            describe("when testingFunc()") {
                var result: String?
                
                beforeEach {
                    result = uut?.testingFunc()
                }
                
                it("returns 'testingFunc") {
                    expect(result).to(equal("testingFunc called"))
                }
            }
        }
    }
}
