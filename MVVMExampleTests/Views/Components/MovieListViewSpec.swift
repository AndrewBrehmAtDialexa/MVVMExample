import Quick
import Nimble
import SwiftUI
import ViewInspector
@testable import MVVMExample

class MovieListViewSpec: QuickSpec {
    override func spec() {
        describe("MovieListView") {
            var uut: MovieListView?
            var movieListScreenViewModel: MockMovieListScreenViewModel?
            
            beforeEach {
                movieListScreenViewModel = MockMovieListScreenViewModel()
                movieListScreenViewModel?.movies = [
                    MovieViewModel(withMovie: MockMovie.create(withPlacement: "1")),
                    MovieViewModel(withMovie: MockMovie.create(withPlacement: "2")),
                    MovieViewModel(withMovie: MockMovie.create(withPlacement: "3")),
                ]
                uut = MovieListView(withMovieListScreenViewModel: movieListScreenViewModel!)
            }
            
            describe("the body") {
                var movieList: InspectableView<ViewType.List>?
                
                beforeEach {
                    movieList = uut?.findChild(type: ViewType.List.self, withId: "movieList")
                }
                
                it("has a List with .id 'movieList'") {
                    expect(movieList).toNot(beNil())
                }
                
                describe("movieList") {
                    var content: [InspectableView<ViewType.View<MovieListCell>>]?
                    
                    beforeEach {
                        content = movieList?.findAll(MovieListCell.self)
                    }
                    
                    it("has content of MovieListCell") {
                        expect(content).toNot(beNil())
                    }
                    
                    describe("that content") {
                        it("has 3 cells") {
                            expect(content?.count).to(equal(3))
                        }
                    }
                }
            }
        }
    }
}
