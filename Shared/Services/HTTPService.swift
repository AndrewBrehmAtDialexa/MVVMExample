import Foundation

class HTTPService {
    
    static let shared = HTTPService()
    var session = URLSession.shared
    
    func get(withUrl url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
        session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            completion(.success(data))
        }.resume()
    }
}
