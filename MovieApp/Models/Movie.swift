import SwiftUI

struct Movie: Identifiable {
    let id = UUID()
    var title: String
    var filmmaker: String // New property for filmmaker's name
    var backgroundColor: Color
}
