import Quick
import Nimble
@testable import MVVMExample

class MovieListScreenViewModelSpec: QuickSpec {
    override func spec() {
        describe("MovieListScreenViewModel") {
            var uut: MovieListScreenViewModel?
            var imdbMovieService: MockImdbMovieService?
            
            beforeEach {
                uut = MovieListScreenViewModel()
                imdbMovieService = MockImdbMovieService()
                uut?.imdbMovieService = imdbMovieService!
            }
            
            // MARK: - @Published vars
            
            describe("@Published .movies") {
                it("has a value of an empty array") {
                    expect(uut?.movies.count).to(equal(0))
                }
                
                describe("when .movies changes") {
                    beforeEach {
                        uut?.movies = [MovieViewModel(movie: MockMovie.create())]
                    }
                    
                    it("publishes the change") {
                        let _ = uut?.$movies.sink { publihedValue in
                            expect(publihedValue.first?.title).to(equal("someTitle"))
                        }
                    }
                }
            }
            
            describe("@Published .errorMessageToPresent") {
                it("has a value of nil") {
                    expect(uut?.errorMessageToPresent).to(beNil())
                }
                
                describe("when .errorMessageToPresent changes") {
                    beforeEach {
                        uut?.errorMessageToPresent = "someChange"
                    }
                    
                    it("publishes the change") {
                        let _ = uut?.$errorMessageToPresent.sink { publihedValue in
                            expect(publihedValue).to(equal("someChange"))
                        }
                    }
                }
            }
            
            // MARK: - Methods
            
            describe("when .getMovies(forSearchTerm:)") {
                beforeEach {
                    uut?.getMovies(forSearchTerm: "someSearchTerm")
                }
                
                it("calls .imdbMovieService.getMovies(bySearchTerm:") {
                    expect(imdbMovieService?.getMoviesWasCalled).to(beTrue())
                }
                
                describe("that call") {
                    describe("when the result is successful") {
                        describe("when the data contains Movies") {
                            beforeEach {
                                imdbMovieService?.givenCompletion?(.success([MockMovie.create()]))
                            }
                            
                            it("sets .movies to mapped result") {
                                expect(uut?.movies.first?.title).toEventually(equal("someTitle"))
                            }
                        }
                        describe("when the data is nil") {
                            beforeEach {
                                imdbMovieService?.givenCompletion?(.success(nil))
                            }
                            
                            it("sets does not change the .movies value") {
                                expect(uut?.movies.count).toEventually(equal(0))
                            }
                        }
                    }
                    
                    describe("when the result is a failure") {
                        beforeEach {
                            imdbMovieService?.givenCompletion?(.failure(MovieError()))
                        }
                        
                        it("sets .errorMessageToPresent to the MovieError.error message") {
                            expect(uut?.errorMessageToPresent).toEventually(equal("There was a problem getting the movies. Sorry, try again."))
                        }
                    }
                }
            }
        }
    }
}
