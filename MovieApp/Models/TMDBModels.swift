import Foundation

// TMDB Search Response
struct TMDBSearchResponse: Codable {
    let results: [TMDBMovie]
}

// TMDB Movie Model
struct TMDBMovie: Codable, Identifiable {
    let id: Int
    let title: String
    let posterPath: String?
    let releaseDate: String?
    let overview: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case overview
    }

    // Helper to get release year
    var year: String? {
        guard let releaseDate = releaseDate else { return nil }
        return String(releaseDate.prefix(4))
    }
}
