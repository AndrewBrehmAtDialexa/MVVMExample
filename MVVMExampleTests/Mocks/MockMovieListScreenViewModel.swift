@testable import MVVMExample

class MockMovieListScreenViewModel: MovieListScreenViewModel {
    var getMoviesWasCalled = false
    var givenSearch: String?
    
    override func getMovies(forSearchTerm search: String) {
        getMoviesWasCalled = true
        givenSearch = search
    }
}
