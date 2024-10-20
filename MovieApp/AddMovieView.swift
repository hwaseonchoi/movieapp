import SwiftUI

struct AddMovieView: View {
    @State private var movieTitle: String = ""
    @Binding var movies: [Movie]  // Binding to the movies array

    var body: some View {
        VStack {
            TextField("Enter movie title", text: $movieTitle)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding()

            Button(action: {
                if !movieTitle.isEmpty {
                    let newMovie = Movie(title: movieTitle, backgroundColor: generateRandomPastelColor())
                    movies.append(newMovie)  // Add the new movie to the array
                    movieTitle = ""  // Clear the text field
                }
            }) {
                Text("Add Movie")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }

    // Helper function to generate random pastel colors
    func generateRandomPastelColor() -> Color {
        return Color(
            red: Double.random(in: 0.7...1.0),
            green: Double.random(in: 0.7...1.0),
            blue: Double.random(in: 0.7...1.0)
        )
    }
}
