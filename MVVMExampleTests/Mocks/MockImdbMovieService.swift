@testable import MVVMExample

class MockImdbMovieService: ImdbMovieService {
    var getMoviesWasCalled = false
    var givenSearch: String?
    var givenCompletion: ((Result<[Movie]?, MovieError>) -> Void)?
    
    override func getMovies(bySearchTerm search: String, completion: @escaping (Result<[Movie]?, MovieError>) -> Void) {
        
        getMoviesWasCalled = true
        givenSearch = search
        givenCompletion = completion
    }
}
