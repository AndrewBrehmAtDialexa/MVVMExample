import Quick
import Nimble
@testable import MVVMExample
import SwiftUI

class MovieViewModelSpec: QuickSpec {
    override func spec() {
        describe("MovieViewModel") {
            var uut: MovieViewModel?
            
            beforeEach {
                let movie = MockMovie.create()
                uut = MovieViewModel(withMovie: movie)
            }
            
            describe("on .init()") {
                describe("the computed variables") {
                    it("sets .title to 'someTitle") {
                        expect(uut?.title).to(equal("someTitle"))
                    }
                    
                    it("sets .year to 'someYear") {
                        expect(uut?.year).to(equal("someYear"))
                    }
                    
                    it("sets .imdbId to 'someImdbId") {
                        expect(uut?.imdbId).to(equal("someImdbId"))
                    }
                    
                    it("sets .posterUrl to 'somePosterUrl") {
                        expect(uut?.posterUrl).to(equal("somePosterUrl"))
                    }
                    
                    describe("posterImagePadding") {
                        describe("when .posterImage is .placeHolderImage") {
                            beforeEach {
                                uut?.posterImage = uut!.placeHolderImage
                            }
                            
                            it("sets it as EdgeInsets(top: 50, leading: 25, bottom: 50, trailing: 25)") {
                                expect(uut?.posterImagePadding).to(equal(EdgeInsets(top: 50, leading: 25, bottom: 50, trailing: 25)))
                            }
                        }
                        
                        describe("when .posterImage is NOT .placeHolderImage") {
                            beforeEach {
                                uut?.posterImage = UIImage(systemName: "person")!
                            }
                            
                            it("sets it as EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)") {
                                expect(uut?.posterImagePadding).to(equal(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)))
                            }
                        }
                    }
                }
                
                it("sets .posterImage to .placeHolderImage") {
                    expect(uut?.posterImage).to(equal(uut?.placeHolderImage))
                }
            }
            
            describe("when .getPosterImage()") {
                describe("when it is successful") {
                    beforeEach {
                        let stub = StubData()
                        stub.addMockUrl(forUrl: "somePosterUrl", fromResource: "posterImage", withExtension: "jpg")
                        stub.create()
                        
                        uut?.getPosterImage()
                    }
                    
                    it("sets .posterImage to the returned image") {
                        let posterReturn = StubData().createImage(fromResource: "posterImage", withExtension: "jpg")
                        expect(uut?.posterImage.pngData()).toEventually(equal(posterReturn.pngData()))
                    }
                }
                
                describe("when it is a failure") {
                    beforeEach {
                        let stub = StubData()
                        stub.addMockUrl(forUrl: "somePosterUrl", fromResource: "posterImage", withExtension: "jpg", withStatusCode: 400)
                        stub.create()
                        
                        uut?.getPosterImage()
                    }
                    
                    it("keeps .posterImage set as the default .placeHolderImage") {
                        expect(uut?.posterImage.pngData()).to(equal(uut?.placeHolderImage.pngData()))
                    }
                }
            }
        }
    }
}
