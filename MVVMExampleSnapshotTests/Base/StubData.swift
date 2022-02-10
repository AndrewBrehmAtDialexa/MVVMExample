import Foundation

class StubData {
    var mockURLs = [URL?: (error: Error?, data: Data?, response: HTTPURLResponse?)]()
    
    func create(forUrl url: String, forResource resourceName: String, withExtension ext: String, withStatusCode code: Int = 200) {
        let testBundle = Bundle(for: type(of: self))
        guard let fileUrl = testBundle.url(forResource: resourceName, withExtension: ext)
          else { fatalError() }
        let fileData = try? Data(contentsOf: fileUrl)

        let _ = MockURLSession().createMock(withUrl: URL(string: url)!, data: fileData, statusCode: code)
    }
    
    func create() {
        let _ = MockURLSession().createBatchMocks(withUrls: mockURLs)
    }
    
    func addMockUrl(forUrl urlString: String,
                    fromResource resourceName: String,
                    withExtension ext: String,
                    withStatusCode code: Int = 200,
                    withError error: Error? = nil,
                    httpVersion: String? = nil,
                    headerFields: [String : String]? = nil
    ) {
        let url = URL(string: urlString)!
        
        let testBundle = Bundle(for: type(of: self))
        guard let fileUrl = testBundle.url(forResource: resourceName, withExtension: ext)
          else { fatalError() }
        let fileData = try? Data(contentsOf: fileUrl)
        
        let response = HTTPURLResponse(url: url, statusCode: code, httpVersion: httpVersion, headerFields: headerFields)
        
        
        mockURLs[url] = (error: error, data: fileData, response: response)
    }
}
