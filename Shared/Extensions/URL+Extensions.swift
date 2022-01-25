import Foundation

extension URL {
    static func forOmdb(withSearchTerm search: String) -> URL? {
        return URL(string: "https://www.omdbapi.com/?s=\(search)&apikey=\(Constants.omdbApiKey)")
    }
}
