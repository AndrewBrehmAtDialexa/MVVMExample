import Foundation

class HTTPService {
    
    static let shared = HTTPService()
    var session = URLSession.shared
    
    func get(withUrl url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
        session.dataTask(with: url) { data, response, error in
            if let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) {
                
                guard let data = data, data.count > 0, error == nil else {
                    return completion(.failure(.noData))
                }
                
                completion(.success(data))
                
            } else {
                completion(.failure(.noData))
            }
        }.resume()
    }
}
