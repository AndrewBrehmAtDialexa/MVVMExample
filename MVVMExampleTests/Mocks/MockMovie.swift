@testable import MVVMExample

struct MockMovie {
    static func create(withPlacement place: String = "") -> Movie {
        return Movie(title: "someTitle\(place)", year: "someYear\(place)", imdbId: "someImdbId\(place)", type: "someType\(place)", posterUrl: "somePosterUrl\(place)")
    }
}
