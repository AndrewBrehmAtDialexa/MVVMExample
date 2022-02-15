import Quick
import Nimble
import SwiftUI
import ViewInspector
@testable import MVVMExample

class MovieListCellSpec: QuickSpec {
    override func spec() {
        
        describe("MovieListCell") {
            var uut: MovieListCell?
            var movieViewModel: MovieViewModel?
            
            beforeEach {
                movieViewModel = MovieViewModel(withMovie: MockMovie.create())
                uut = MovieListCell(withMovieViewModel: movieViewModel!)
            }
            
            describe("the body") {
                var mainHStack: InspectableView<ViewType.HStack>?
                
                beforeEach {
                    mainHStack = uut?.findChild(type: ViewType.HStack.self, withId: "mainHStack")
                }
                
                it("has a HStack with .id 'mainHStack'") {
                    expect(mainHStack).toNot(beNil())
                }
                
                describe("mainHStack") {
                    var posterImage: InspectableView<ViewType.Image>?
                    var textHolderVStack: InspectableView<ViewType.VStack>?
                    
                    beforeEach {
                        posterImage = mainHStack?.findChild(type: ViewType.Image.self, withId: "posterImage")
                        textHolderVStack = mainHStack?.findChild(type: ViewType.VStack.self, withId: "textHolderVStack")
                    }
                    
                    it("has an Image with .id 'posterImage'") {
                        expect(posterImage).toNot(beNil())
                    }
                    
                    describe("posterImage") {                        
                        it("sets the .uiImage to .movieViewModel.placeHolderImage") {
                            expect(try? posterImage?.actualImage().uiImage()).to(equal(movieViewModel?.placeHolderImage))
                        }
                        
                        it("has a .frame of (width: 100, height: 150, alignment: .center)") {
                            expect(try posterImage?.fixedFrame()).to(equal( (width: 100, height: 150, alignment: .center) ))
                        }
                        
                        it("has an .aspectRation of .fill") {
                            expect(try posterImage?.aspectRatio().contentMode).to(equal(.fill))
                        }
                    }
                    
                    it("has a VStack with .id 'textHolderVStack'") {
                        expect(textHolderVStack).toNot(beNil())
                    }
                    
                    describe("textHolderVStack") {
                        var movieTitleText: InspectableView<ViewType.Text>?
                        var movieYearText: InspectableView<ViewType.Text>?
                        
                        beforeEach {
                            movieTitleText = textHolderVStack?.findChild(type: ViewType.Text.self, withId: "movieTitleText")
                            movieYearText = textHolderVStack?.findChild(type: ViewType.Text.self, withId: "movieYearText")
                        }
                        
                        it("has a Text with .id 'movieTitleText'") {
                            expect(movieTitleText).toNot(beNil())
                        }
                        
                        describe("movieTitleText") {
                            it("has text equal to 'someTitle'") {
                                expect(try? movieTitleText?.string()).to(equal("someTitle"))
                            }
                        }
                        
                        it("has a Text with .id 'movieYearText'") {
                            expect(movieYearText).toNot(beNil())
                        }
                        
                        describe("movieYearText") {
                            it("has text equal to 'someYear'") {
                                expect(try? movieYearText?.string()).to(equal("someYear"))
                            }
                        }
                    }
                }
            }
        }
    }
}
