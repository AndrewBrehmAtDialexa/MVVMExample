import Quick
import Nimble
import SwiftUI
import ViewInspector
@testable import MVVMExample

class MovieSearchScreenSpec: QuickSpec {
    override func spec() {
        describe("MovieSearchScreen") {
            var uut: MovieSearchScreen?
            var movieListScreenViewModel: MockMovieListScreenViewModel?
            
            beforeEach {
                var movieSearchScreen = MovieSearchScreen()
                let _ = movieSearchScreen.on(\.didAppear) { view in
                    uut = try? view.actualView()
                    movieListScreenViewModel = MockMovieListScreenViewModel()
                    uut?.movieListScreenViewModel = movieListScreenViewModel!
                }
                
                ViewHosting.host(view: movieSearchScreen)
                /* NOTE:
                 ViewInspector uses the ViewHosting method (in combination with .didAppear) to access @State, @Binding, etc in the actualView(). This allows testing of changes to @State vars.
                 
                 Initializing the View using ViewHosting is not needed unless it has @State vars.
                 
                 */
            }
            
            describe("the body") {
                var mainVStack: InspectableView<ViewType.VStack>?
                
                beforeEach {
                    mainVStack = uut?.findChild(type: ViewType.VStack.self, withId: "mainVStack")
                }
                
                it("has a VStack with .id 'mainVStack'") {
                    expect(mainVStack).toNot(beNil())
                }
                
                describe("mainVStack") {
                    var searchHolder: InspectableView<ViewType.VStack>?
                    var movieListView: InspectableView<ViewType.View<MovieListView>>?
                    
                    beforeEach {
                        searchHolder = mainVStack?.findChild(type: ViewType.VStack.self, withId: "searchHolder")
                        movieListView = try? mainVStack?.find(MovieListView.self)
                    }
                    
                    it("has a VStack with .id 'searchHolder'") {
                        expect(searchHolder).toNot(beNil())
                    }
                    
                    describe("searchHolder") {
                        var searchField: InspectableView<ViewType.TextField>?
                        
                        beforeEach {
                            searchField = searchHolder?.findChild(type: ViewType.TextField.self, withId: "searchField")
                        }
                        
                        it("has Text with value of 'Enter a Movie'") {
                            expect(try searchHolder?.find(text: "Enter a Movie")).toNot(beNil())
                        }
                        
                        it("has a TextField with .id 'searchField") {
                            expect(searchField).toNot(beNil())
                        }
                        
                        describe("searchField") {
                            var title: InspectableView<ViewType.Text>?
                            
                            beforeEach {
                                title = try? searchField?.find(text: "Movie Title")
                            }
                            
                            it("has a placeholder title of 'Movie Title'") {
                                expect(title).toNot(beNil())
                            }
                            
                            describe("when a user hits return and calls .onCommit()") {
                                describe("when .searchTerm.count is > 0 ") {
                                    
                                    beforeEach {
                                        uut?.searchTerm = "someSearchTerm"
                                        try? searchField?.callOnCommit()
                                    }
                                    
                                    it("calls .movieListScreenViewModel.getMovies()") {
                                        expect(movieListScreenViewModel?.getMoviesWasCalled).to(beTrue())
                                    }
                                    
                                    describe("that call") {
                                        it("has a givenSearchTerm of 'someSearchTerm'") {
                                            expect(movieListScreenViewModel?.givenSearch).to(equal("someSearchTerm"))
                                        }
                                    }
                                }
                                
                                describe("when .searchTerm is blank") {
                                    beforeEach {
                                        uut?.searchTerm = ""
                                        try? searchField?.callOnCommit()
                                    }
                                    
                                    it("does not call .movieListScreenViewModel.getMovies()") {
                                        expect(movieListScreenViewModel?.getMoviesWasCalled).to(beFalse())
                                    }
                                }
                            }
                            
                            it("has .padding") {
                                expect(searchField?.hasPadding()).to(beTrue())
                            }
                            
                            describe("the border") {
                                var border: (shapeStyle: Color, width: CGFloat)?
                                
                                beforeEach {
                                    border = try? searchField?.border(Color.self)
                                }
                                
                                it("has a shapeStyle of Color(.black)") {
                                    expect(border?.shapeStyle).to(equal(Color(.black)))
                                }
                                it("has a .width of 2.0") {
                                    expect(border?.width).to(equal(2.0))
                                }
                            }
                        }
                    }
                    
                    
                    it("has a MovieListView") {
                        expect(movieListView).toNot(beNil())
                    }
                }
                
                it("has a .navigationTitle of 'Movies'") {
                    //TODO: .navigationTitle() still under development in ViewInspector
                }
            }
        }
    }
}
