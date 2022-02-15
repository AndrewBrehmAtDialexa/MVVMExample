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
# Getting Data
(see [MovieSearchScreenSnapshotTest](/MVVMExampleSnapshotTests/Views/Screens/MovieSearchScreenSnapshotTest.swift) > testListWithMoviesAndNoImages)
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
