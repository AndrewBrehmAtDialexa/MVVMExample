import Foundation
@testable import MVVMExample

class MockHTTPService: HTTPService {
    var getWasCalled = false
    var givenUrl: URL?
    var givenCompletion: ((Result<Data, NetworkError>) -> Void)?
    
    override func get(withUrl url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        getWasCalled = true
        givenUrl = url
        givenCompletion = completion
    }
}
