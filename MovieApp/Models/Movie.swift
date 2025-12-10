import SwiftUI

struct Movie: Identifiable, Codable {
    let id: UUID
    var title: String
    var filmmaker: String
    var backgroundColor: Color

    // TMDB properties (optional for backward compatibility)
    var posterPath: String?
    var tmdbId: Int?
    var year: String?

    // Custom coding keys to handle Color
    enum CodingKeys: String, CodingKey {
        case id, title, filmmaker, backgroundColorComponents
        case posterPath, tmdbId, year
    }

    // Encode Color as RGB components
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(filmmaker, forKey: .filmmaker)

        // Convert Color to RGB components
        let components = backgroundColor.cgColor?.components ?? [0.5, 0.5, 0.5, 1.0]
        try container.encode(components, forKey: .backgroundColorComponents)

        // Encode optional TMDB properties
        try container.encodeIfPresent(posterPath, forKey: .posterPath)
        try container.encodeIfPresent(tmdbId, forKey: .tmdbId)
        try container.encodeIfPresent(year, forKey: .year)
    }

    // Decode Color from RGB components
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        filmmaker = try container.decode(String.self, forKey: .filmmaker)

        let components = try container.decode([CGFloat].self, forKey: .backgroundColorComponents)
        backgroundColor = Color(
            red: components[0],
            green: components[1],
            blue: components[2],
            opacity: components.count > 3 ? components[3] : 1.0
        )

        // Decode optional TMDB properties (nil if not present for backward compatibility)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        tmdbId = try container.decodeIfPresent(Int.self, forKey: .tmdbId)
        year = try container.decodeIfPresent(String.self, forKey: .year)
    }

    // Regular initializer
    init(id: UUID = UUID(), title: String, filmmaker: String, backgroundColor: Color, posterPath: String? = nil, tmdbId: Int? = nil, year: String? = nil) {
        self.id = id
        self.title = title
        self.filmmaker = filmmaker
        self.backgroundColor = backgroundColor
        self.posterPath = posterPath
        self.tmdbId = tmdbId
        self.year = year
    }
}
