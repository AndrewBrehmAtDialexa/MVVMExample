import Foundation
import UIKit

class ImdbMovieService {
    
    var httpService = HTTPService.shared
    
    func getMovies(bySearchTerm search: String, completion: @escaping (Result<[Movie]?, MovieError>) -> Void) {
        guard let url = URL.forOmdb(withSearchTerm: search) else {
            return completion(.failure(MovieError(networkError: .badUrl)))
        }
        
        httpService.get(withUrl: url, completion: { result in
            switch result {
            case.success(let data):
                
                if let movies = self.decodeMovieSearch(fromData: data) {
                    completion(.success(movies))
                } else if let error = self.decodeMovieSearchError(fromData: data) {
                    completion(.failure(error))
                } else {
                    completion(.failure(MovieError(networkError: .decodingError)))
                }
                
            case.failure(let error):
                completion(.failure(MovieError(networkError: error)))
            }
        })
    }
    
    private func decodeMovieSearch(fromData data: Data) -> [Movie]? {
        guard let searchResponse = try? JSONDecoder().decode(MovieSearch.self, from: data) else {
            return nil
        }

        return searchResponse.searchResult
    }
    
    private func decodeMovieSearchError(fromData data: Data) -> MovieError? {
        guard let searchResponse = try? JSONDecoder().decode(MovieError.self, from: data) else {
            return nil
        }

        return searchResponse
    }
    
    // MARK: - Images
    
    func getPosterImage(forUrlString urlString: String, completion: @escaping (Result<UIImage, MovieError>) -> Void) {
        guard let url = URL.forPosterImage(withUrlString: urlString) else {
            return completion(.failure(MovieError(networkError: .badUrl)))
        }
        
        httpService.get(withUrl: url, completion: { result in
            switch result {
            case.success(let data):
                
                if let image = self.decodeImage(fromData: data) {
                    completion(.success(image))
                } else {
                    completion(.failure(MovieError(networkError: .decodingError)))
                }
                
            case.failure(let error):
                completion(.failure(MovieError(networkError: error)))
            }
        })
    }
    
    private func decodeImage(fromData data: Data) -> UIImage? {
        return UIImage(data: data)
    }
}
