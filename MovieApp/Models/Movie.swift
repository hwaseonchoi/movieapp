import SwiftUI

struct Movie: Identifiable, Codable {
    let id: UUID
    var title: String
    var filmmaker: String
    var backgroundColor: Color

    // Custom coding keys to handle Color
    enum CodingKeys: String, CodingKey {
        case id, title, filmmaker, backgroundColorComponents
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
    }

    // Regular initializer
    init(id: UUID = UUID(), title: String, filmmaker: String, backgroundColor: Color) {
        self.id = id
        self.title = title
        self.filmmaker = filmmaker
        self.backgroundColor = backgroundColor
    }
}
