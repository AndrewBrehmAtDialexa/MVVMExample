import Foundation

extension URL {
    static func forOmdb(withSearchTerm search: String) -> URL? {
        return URL(string: "https://www.omdbapi.com/?s=\(search)&apikey=\(Constants.omdbApiKey)")
    }
    
    static func forPosterImage(withUrlString urlString: String) -> URL? {
        return URL(string: urlString)
    }
}
