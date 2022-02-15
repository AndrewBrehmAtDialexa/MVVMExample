import Quick
import Nimble
@testable import MVVMExample

class ImdbMovieServiceSpec: QuickSpec {
    override func spec() {
        describe("ImdbMovieService") {
            var uut: ImdbMovieService?
            var httpService: MockHTTPService?
            var movieCompletion: ((Result<[Movie]?, MovieError>) -> Void)?
            var movieCompletionData: [Movie]?
            var movieCompletionError: MovieError?
            var posterCompletion: ((Result<UIImage, MovieError>) -> Void)?
            var posterCompletionImage: UIImage?
            var posterCompletionError: MovieError?
            var successWasCalled = false
            var failureWasCalled = false
            
            
            beforeEach {
                uut = ImdbMovieService()
                httpService = MockHTTPService()
                uut?.httpService = httpService!
                
                successWasCalled = false
                failureWasCalled = false
                
                movieCompletion = { result in
                    switch result {
                    case.success(let data):
                        successWasCalled = true
                        movieCompletionData = data
                    case.failure(let error):
                        failureWasCalled = true
                        movieCompletionError = error
                    }
                }
                
                posterCompletion = { result in
                    switch result {
                    case.success(let image):
                        successWasCalled = true
                        posterCompletionImage = image
                    case.failure(let error):
                        failureWasCalled = true
                        posterCompletionError = error
                    }
                }
            }
            
            describe("when .getMovies(bySearchTerm:completion:)") {
                describe("and the search term is invalid") {
                    beforeEach {
                        uut?.getMovies(bySearchTerm: "|", completion: movieCompletion!)
                    }
                    
                    it("calls the completion .failure") {
                        expect(failureWasCalled).to(beTrue())
                    }
                    
                    describe("that call") {
                        it("has a MovieError.error equal to 'There was a problem getting the movies. Sorry, try again.'") {
                            expect(movieCompletionError?.error).to(equal("There was a problem getting the movies. Sorry, try again."))
                        }
                        it("has a MovieError.networkError equal to .badUrl") {
                            expect(movieCompletionError?.networkError).to(equal(.badUrl))
                        }
                    }
                }
                
                describe("and the search term is valid") {
                    beforeEach {
                        uut?.getMovies(bySearchTerm: "someSearchTerm", completion: movieCompletion!)
                    }
                    
                    it("calls .httpService.get()") {
                        expect(httpService?.getWasCalled).to(beTrue())
                    }
                    
                    describe("that call") {
                        describe("when it is a success") {
                            describe("and the response data can be decoded") {
                                describe("and that decoding is Movie data") {
                                    beforeEach {
                                        let movieSearch = MovieSearch(searchResult: [
                                            MockMovie.create()
                                        ])
                                        let mockData = try? JSONEncoder().encode(movieSearch)
                                        
                                        httpService?.givenCompletion?(.success(mockData!))
                                    }
                                    
                                    it("calls the completion .success") {
                                        expect(successWasCalled).to(beTrue())
                                    }
                                    
                                    describe("that call") {
                                        it("has the expected Movie data") {
                                            expect(movieCompletionData?.first?.title).to(equal("someTitle"))
                                        }
                                    }
                                }
                                
                                describe("and that decoding is MoviewError data") {
                                    beforeEach {
                                        let movieError = MovieError(error: "someError", networkError: nil)
                                        let mockData = try? JSONEncoder().encode(movieError)
                                        
                                        httpService?.givenCompletion?(.success(mockData!))
                                    }
                                    
                                    it("calls the completion .failure") {
                                        expect(failureWasCalled).to(beTrue())
                                    }
                                    
                                    describe("that call") {
                                        it("has a MovieError.error equal to 'someError'") {
                                            expect(movieCompletionError?.error).to(equal("someError"))
                                        }
                                        it("has a nil MovieError.networkError") {
                                            expect(movieCompletionError?.networkError).to(beNil())
                                        }
                                    }
                                }
                            }
                            
                            describe("and the response data can not be decoded") {
                                beforeEach {
                                    let mockModel = MockModel(someString: "thisCannotBeDecoded")
                                    let mockData = try? JSONEncoder().encode(mockModel)
                                    
                                    httpService?.givenCompletion?(.success(mockData!))
                                }
                                
                                it("calls the completion .failure") {
                                    expect(failureWasCalled).to(beTrue())
                                }
                                
                                describe("that call") {
                                    it("has a MovieError.error equal to 'There was a problem getting the movies. Sorry, try again.'") {
                                        expect(movieCompletionError?.error).to(equal("There was a problem getting the movies. Sorry, try again."))
                                    }
                                    it("has a MovieError.networkError equal to .decodingError") {
                                        expect(movieCompletionError?.networkError).to(equal(.decodingError))
                                    }
                                }
                            }
                        }
                        
                        describe("when it is a failure") {
                            beforeEach {
                                httpService?.givenCompletion?(.failure(.noData))
                            }
                            
                            it("calls the completion .failure") {
                                expect(failureWasCalled).to(beTrue())
                            }
                            
                            describe("that call") {
                                it("has a MovieError.error equal to 'There was a problem getting the movies. Sorry, try again.'") {
                                    expect(movieCompletionError?.error).to(equal("There was a problem getting the movies. Sorry, try again."))
                                }
                                it("has a MovieError.networkError equal to the passed NetworkError") {
                                    expect(movieCompletionError?.networkError).to(equal(.noData))
                                }
                            }
                        }
                    }
                }
            }
            
            describe("when .getPosterImage(forUrlString:,completion:)") {
                describe("and the url is invalid") {
                    beforeEach {
                        uut?.getPosterImage(forUrlString: "|", completion: posterCompletion!)
                    }
                    
                    it("calls the completion .failure") {
                        expect(failureWasCalled).to(beTrue())
                    }
                    
                    describe("that call") {
                        it("has a MovieError.error equal to 'There was a problem getting the movies. Sorry, try again.'") {
                            expect(posterCompletionError?.error).to(equal("There was a problem getting the movies. Sorry, try again."))
                        }
                        it("has a MovieError.networkError equal to .badUrl") {
                            expect(posterCompletionError?.networkError).to(equal(.badUrl))
                        }
                    }
                }
                
                describe("and the url is valid") {
                    beforeEach {
                        uut?.getPosterImage(forUrlString: "someUrl", completion: posterCompletion!)
                    }
                    
                    it("calls .httpService.get()") {
                        expect(httpService?.getWasCalled).to(beTrue())
                    }
                    
                    describe("that call") {
                        describe("when it is a success") {
                            describe("and the response data can be decoded") {
                                describe("and that decoding is Image data") {
                                    beforeEach {
                                        let posterReturn = StubData().createImage(fromResource: "posterImage", withExtension: "jpg")
                                        let mockData = posterReturn.pngData()
                                        httpService?.givenCompletion?(.success(mockData!))
                                    }
                                    
                                    it("calls the completion .success") {
                                        expect(successWasCalled).to(beTrue())
                                    }
                                    
                                    describe("that call") {
                                        it("has the expected Image") {
                                            let posterReturn = StubData().createImage(fromResource: "posterImage", withExtension: "jpg")
                                            expect(posterCompletionImage?.pngData()).toEventually(equal(posterReturn.pngData()))
                                        }
                                    }
                                }
                            }
                            
                            describe("and the response data can not be decoded") {
                                beforeEach {
                                    let mockModel = MockModel(someString: "thisCannotBeDecoded")
                                    let mockData = try? JSONEncoder().encode(mockModel)
                                    
                                    httpService?.givenCompletion?(.success(mockData!))
                                }
                                
                                it("calls the completion .failure") {
                                    expect(failureWasCalled).to(beTrue())
                                }
                                
                                describe("that call") {
                                    it("has a MovieError.error equal to 'There was a problem getting the movies. Sorry, try again.'") {
                                        expect(posterCompletionError?.error).to(equal("There was a problem getting the movies. Sorry, try again."))
                                    }
                                    it("has a MovieError.networkError equal to .decodingError") {
                                        expect(posterCompletionError?.networkError).to(equal(.decodingError))
                                    }
                                }
                            }
                        }
                        
                        describe("when it is a failure") {
                            beforeEach {
                                httpService?.givenCompletion?(.failure(.noData))
                            }
                            
                            it("calls the completion .failure") {
                                expect(failureWasCalled).to(beTrue())
                            }
                            
                            describe("that call") {
                                it("has a MovieError.error equal to 'There was a problem getting the movies. Sorry, try again.'") {
                                    expect(posterCompletionError?.error).to(equal("There was a problem getting the movies. Sorry, try again."))
                                }
                                it("has a MovieError.networkError equal to the passed NetworkError") {
                                    expect(posterCompletionError?.networkError).to(equal(.noData))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
