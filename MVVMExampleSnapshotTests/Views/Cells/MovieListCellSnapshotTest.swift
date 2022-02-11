import SnapshotTesting
import XCTest
import SwiftUI
@testable import MVVMExample

class MovieListCellSnapshotTest: BaseSnapshotTest {
    func testMovieListCellWithPosterImage() {
        let stub = StubData()
        let posterImage = stub.createImage(fromResource: "posterImage", withExtension: "jpg")
        
        let mockMovie = MockMovie.create()
        let movieViewModel = MovieViewModel(withMovie: mockMovie)
        movieViewModel.posterImage = posterImage
        let movieListCell = MovieListCell(withMovieViewModel: movieViewModel)
        
        let uut = UIHostingController<MovieListCell>(rootView: movieListCell)
        
        takeSnapshot(for: uut, clipToComponent: true)
    }
    
    func testMovieListCellWithPlaceholderImage() {
        let mockMovie = MockMovie.create()
        let movieListCell = MovieListCell(withMovieViewModel: MovieViewModel(withMovie: mockMovie))
        
        let uut = UIHostingController<MovieListCell>(rootView: movieListCell)
        
        takeSnapshot(for: uut, clipToComponent: true)
    }
}
