import Foundation
import UIKit

class StubData {
    lazy var testBundle = Bundle(for: type(of: self))
    
    var mockURLs = [URL?: (error: Error?, data: Data?, response: HTTPURLResponse?)]()
    
    func create() {
        let _ = MockURLSession().createBatchMocks(withUrls: mockURLs)
    }
    
    func addMockUrl(
        forUrl urlString: String,
        fromResource resourceName: String,
        withExtension ext: String,
        withStatusCode code: Int = 200,
        withError error: Error? = nil,
        httpVersion: String? = nil,
        headerFields: [String : String]? = nil)
    {
        let url = URL(string: urlString)!
        
        guard let fileUrl = testBundle.url(forResource: resourceName, withExtension: ext)
          else { fatalError() }
        let fileData = try? Data(contentsOf: fileUrl)
        
        let response = HTTPURLResponse(url: url, statusCode: code, httpVersion: httpVersion, headerFields: headerFields)
        
        
        mockURLs[url] = (error: error, data: fileData, response: response)
    }
    
    func createImage(
        fromResource resourceName: String,
        withExtension ext: String) -> UIImage
    {
        
        guard let fileUrl = testBundle.url(forResource: resourceName, withExtension: ext)
          else { fatalError() }
        let imageData = try? Data(contentsOf: fileUrl)
        
        return UIImage(data: imageData!)!
    }
}
