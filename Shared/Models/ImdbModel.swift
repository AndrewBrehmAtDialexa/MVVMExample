import Foundation

struct MovieSearch: Codable {
    var searchResult: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case searchResult = "Search"
    }
}

struct Movie: Codable {
    var title: String
    var year: String
    var imdbId: String
    var type: String
    var posterUrl: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbId = "imdbID"
        case type = "Type"
        case posterUrl = "Poster"
    }
}

struct MovieError: Codable, Error {
    var error: String = "There was a problem getting the movies. Sorry, try again."
    var networkError: NetworkError?
    
    enum CodingKeys: String, CodingKey {
        case error = "Error"
    }
}
