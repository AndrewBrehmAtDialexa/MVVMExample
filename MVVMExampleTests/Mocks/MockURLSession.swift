import Foundation

class MockURLSession {
    var givenUrl: URL?
    var givenData: Data?
    var givenStatusCode: Int?
    var givenHttpVersion: String?
    var givenHeaderFields: [String : String]?
    
    func createMock(
        withUrl url: URL = URL(string: "https://someUrl.com")!,
        data: Data? = nil,
        statusCode: Int,
        httpVersion: String? = nil,
        headerFields: [String : String]? = nil
    ) -> URLSession {
        
        givenUrl = url
        givenData = data
        givenStatusCode = statusCode
        givenHttpVersion = httpVersion
        givenHeaderFields = headerFields
        
        let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: httpVersion, headerFields: headerFields)
        MockURLProtocol.mockURLs = [url: (nil, data, response)]
        
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [MockURLProtocol.self]
        
        return URLSession(configuration: sessionConfiguration)
    }
}
