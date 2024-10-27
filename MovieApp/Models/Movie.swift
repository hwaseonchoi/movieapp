import SwiftUI

struct Movie: Identifiable {
    let id = UUID()
    var title: String
    var filmmaker: String
    var backgroundColor: Color
}
