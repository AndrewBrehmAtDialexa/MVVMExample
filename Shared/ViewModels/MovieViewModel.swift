struct MovieViewModel {
    let movie: Movie
    
    var title: String {
        movie.title
    }
    
    var year: String {
        movie.year
    }
    
    var imdbId: String {
        movie.imdbId
    }
    
    var posterUrl: String {
        movie.posterUrl
    }
}
