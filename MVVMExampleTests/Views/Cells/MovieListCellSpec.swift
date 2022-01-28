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
                movieViewModel = MovieViewModel(movie: MockMovie.create())
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
                    var posterAsyncImage: InspectableView<ViewType.AsyncImage>?
                    var textHolderVStack: InspectableView<ViewType.VStack>?
                    
                    beforeEach {
                        posterAsyncImage = mainHStack?.findChild(type: ViewType.AsyncImage.self, withId: "posterAsyncImage")
                        textHolderVStack = mainHStack?.findChild(type: ViewType.VStack.self, withId: "textHolderVStack")
                    }
                    
                    it("has an AsyncImage with .id 'posterAsyncImage'") {
                        expect(posterAsyncImage).toNot(beNil())
                    }
                    
                    describe("posterAsyncImage") {
                        var image: InspectableView<ViewType.Image>?
                        
                        describe("when it has a valid .movie.posterUrl") {
                            beforeEach {
                                image = try? posterAsyncImage?.contentView(AsyncImagePhase.success(Image(systemName: "person"))).image()
                            }
                            
                            it("returns an Image with .id 'poster'") {
                                expect(try image?.id()).to(equal("poster"))
                            }
                        }
                        
                        describe("when it does not have a valid movie.posterUrl") {
                            beforeEach {
                                image = try? posterAsyncImage?.contentView(AsyncImagePhase.failure(NetworkError.noData)).image()
                            }
                            
                            it("returns an Image with .id 'placeHolder'") {
                                expect(try image?.id()).to(equal("placeHolder"))
                            }
                        }
                        
                        describe("when it is loading the posterUrl") {
                            beforeEach {
                                image = try? posterAsyncImage?.contentView(AsyncImagePhase.empty).image()
                            }
                            
                            it("returns an Image with .id 'placeHolder'") {
                                expect(try image?.id()).to(equal("placeHolder"))
                            }
                        }
                        
                        it("has a .frame of (width: 100, height: 150, alignment: .leading)") {
                            expect(try posterAsyncImage?.fixedFrame()).to(equal( (width: 100, height: 150, alignment: .leading) ))
                        }
                        
                        it("has an .aspectRation of .fill") {
                            expect(try posterAsyncImage?.aspectRatio().contentMode).to(equal(.fill))
                        }
                        
                        it("has a .cornerRadius of 5.0") {
                            expect(try posterAsyncImage?.cornerRadius()).to(equal(5.0))
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
                            // TODO: test
                        }
                        
                        it("has a Text with .id 'movieYearText'") {
                            expect(movieYearText).toNot(beNil())
                        }
                        
                        describe("movieYearText") {
                            // TODO: test
                        }
                    }
                }
            }
        }
    }
}
