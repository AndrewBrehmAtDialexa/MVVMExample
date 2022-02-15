# Using Stub Data
## Dependencies
In order to make stub calls you will need to copy over certain files in this project
* StubData.swift
  * Used to set up all the URL calls you want to intercept along with the response you want to have.
* MockUrlSession.swift
  * Used by StubData to register all the URLs created by StubData.
* MockURLProtocol.swift
  * Used by MockUrlSession to register the MockURLProtocol.

## Set Up
* Whatever stub data you want returned needs to be placed in the Testing Target
  ### EXAMPLE:
  * Target > MVVMExampleSnapshotTests has `batman.json` and `posterImage.jpg`
* If you plan to use these files in multiple Targets you will need to make a copy for each target.
  ### EXAMPLE:
  * `posterImage.jpg` is used in both MVVMExampleSnapshotTests AND MVVMExampleTests targets so they each need their own copy.

## How to Use
### Stubbing Data
* Instantiate StubData
  * `let stub = StubData()`
* Call .addMockUrl() and add in the url string you want to capture, the file name and it's file extension
  *  `stub.addMockUrl(forUrl: url, fromResource: "myStubFileName", withExtension: "json")`
  *  Do this for all the mock calls you want to register.
* call .create()
  * `stub.create()`
```
let stub = StubData()
stub.addMockUrl(forUrl: url, fromResource: "myStubFileName", withExtension: "json")
stub.create()
```
  ### EXAMPLE:
  * Taken from [MovieSearchScreenSnapshotTest](/MVVMExampleSnapshotTests/Views/Screens/MovieSearchScreenSnapshotTest.swift) > testListWithMoviesAndNoImages
```
func testListWithMoviesAndNoImages() {
    let stub = StubData()
    let url = URL.forOmdb(withSearchTerm: "batman")!.absoluteString
    stub.addMockUrl(forUrl: url, fromResource: "batmanStub", withExtension: "json")
    stub.create()

    let movieSearchScreen = MovieSearchScreen()
    movieSearchScreen.movieListScreenViewModel.getMovies(forSearchTerm: "batman")

    let uut = UIHostingController<MovieSearchScreen>(rootView: movieSearchScreen)
    takeSnapshot(for: uut, addToNavigationView: true)
}
```
   * `testListWithMoviesAndNoImages()` sets up the call to the url (`https://www.omdbapi.com/?s=batman&apikey=\(Constants.omdbApiKey)`) and will return the resource of [`batmanStub.json`](/MVVMExampleSnapshotTests/Base/TestResources/batmanStub.json)
   * The MovieSearchScreen is instantiated.
   * The `.movieListScreenViewModel` calls `.getMovies()`
     * This causes the code to make the call through the HTTPService as normal BUT the url has been registered in the MockUrlSession to return what we want it to.
   * `takeSnapshot()` is called to record the snapshot as normal.
   * Result (taken from [MovieSearchScreenSnapshotTest](/MVVMExampleSnapshotTests/__Snapshots__/MovieSearchScreenSnapshotTest/testListWithMoviesAndNoImages.iPadPro12_9.png) > testListWithMoviesAndNoImages)
   * <img src="/MVVMExampleSnapshotTests/__Snapshots__/MovieSearchScreenSnapshotTest/testListWithMoviesAndNoImages.iPadPro12_9.png" width="500">
> NOTE: The image is using all of the Stub data from `batmanStub.json` file.

### Stubbing Images
* Instantiate StubData
  * `let stub = StubData()`
* Call `.createImage()` and add in the url string you want to capture, the file name and it's file extension
  * `let someImage = stub.createImage(fromResource: "myImage", withExtension: "jpg")`
* Inject that image into the View (or test case) you are testing.
  * `myTestCase.imageToShow = someImage`
```
let stub = StubData()
let someImage = stub.createImage(fromResource: "myImage", withExtension: "jpg")
```
  ### EXAMPLE:
  * Taken from [MovieListCellSnapshotTest](/MVVMExampleSnapshotTests/Views/Cells/MovieListCellSnapshotTest.swift) > testMovieListCellWithPosterImage
```
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
```
  * `posterImage` is stubbed from the `posterImage.jpg` file.
  * `movieViewModel` is instantiated and its `.posterImage` var is injected with the stubbed image.
  * `takeSnapshot()` is called to record the snapshot as normal.
  * Result (taken from [MovieListCellSnapshotTest](/MVVMExampleSnapshotTests/__Snapshots__/MovieListCellSnapshotTest/testMovieListCellWithPosterImage.iPhoneSe.png) > testMovieListCellWithPosterImage)
  * <img src="/MVVMExampleSnapshotTests/__Snapshots__/MovieListCellSnapshotTest/testMovieListCellWithPosterImage.iPhoneSe.png" width="500">
> NOTE: The image is using the `posterImage.jpg` as the cell's image.

### Stubbing Asynchronous Images
* As above (see [Stubbing Data](#stubbing-data)), make the Data call.
* `.wait()` for the Stub call to complete
  * Create an `XCTNSPredicateExpectation` and wait for that expectation to be fulfilled.
```
let expectation = XCTNSPredicateExpectation(
    predicate: NSPredicate(format: "theViewToTest.viewModel.items.count > 0"),
    object: movieSearchScreen)

_ = XCTWaiter.wait(for: [expectation], timeout: 1, enforceOrder: true)
```
* When the data call is complete create the image(s) as above (see [Stubbing Images](#stubbing-images))
* Inject your image(s)
```
let someImage = stub.createImage(fromResource: "myImage", withExtension: "jpg")
for item in theViewToTest.viewModel.items {
    item.imageToShow = someImage
}
```
  ### EXAMPLE:
  * Taken from [MovieSearchScreenSnapshotTest](/MVVMExampleSnapshotTests/Views/Screens/MovieSearchScreenSnapshotTest.swift) > testListWithMoviesAndImages
```
func testListWithMoviesAndImages() {
    let stub = StubData()
    let url = URL.forOmdb(withSearchTerm: "batman")!.absoluteString
    stub.addMockUrl(forUrl: url, fromResource: "batmanStub", withExtension: "json")
    stub.create()

    let movieSearchScreen = MovieSearchScreen()
    movieSearchScreen.movieListScreenViewModel.getMovies(forSearchTerm: "batman")

    let moviesPopulatedExpectation = XCTNSPredicateExpectation(
        predicate: NSPredicate(format: "movieSearchScreen.movieListScreenViewModel.movies.count > 0"),
        object: movieSearchScreen)

    _ = XCTWaiter.wait(for: [moviesPopulatedExpectation],
                        timeout: 1, enforceOrder: true)

    let posterImage = stub.createImage(fromResource: "posterImage", withExtension: "jpg")
    for movie in movieSearchScreen.movieListScreenViewModel.movies {
        movie.posterImage = posterImage
    }

    let uut = UIHostingController<MovieSearchScreen>(rootView: movieSearchScreen)
    takeSnapshot(for: uut, addToNavigationView: true)
}
```
 * `testListWithMoviesAndImages()` sets up the call to the url and will return the resource of [`batmanStub.json`](/MVVMExampleSnapshotTests/Base/TestResources/batmanStub.json)
   * The MovieSearchScreen is instantiated.
   * The `.movieListScreenViewModel` calls `.getMovies()`
   * An `XCTNSPredicateExpectation` is created and set to wait for `"movieSearchScreen.movieListScreenViewModel.movies.count > 0"`
     * Once the expectation is fulfilled (i.e. the url call is complete and the data is decoded) it continues on in the test
   * The Stub image is created
   * It loops through the view model's `.movies` and injects the Stub image into the `.posterImage`
   * `takeSnapshot()` is called to record the snapshot as normal.
   * Result (taken from [MovieSearchScreenSnapshotTest](/MVVMExampleSnapshotTests/__Snapshots__/MovieSearchScreenSnapshotTest/testListWithMoviesAndImages.iPadPro12_9.png) > testListWithMoviesAndImages)
   * <img src="/MVVMExampleSnapshotTests/__Snapshots__/MovieSearchScreenSnapshotTest/testListWithMoviesAndImages.iPadPro12_9.png" width="500">
> NOTE: The image is using all of the Stub data from `batmanStub.json` file AND the injected `posterImage.jpg`.



