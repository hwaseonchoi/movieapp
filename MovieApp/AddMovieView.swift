import SwiftUI

struct AddMovieView: View {
    @State private var movieTitle: String = ""
    @State private var filmmakerName: String = ""
    @Binding var movies: [Movie]  // Binding to the movies array
    @Binding var selectedTab: Int  // Binding to control the selected tab in ContentView

    var body: some View {
        VStack {
            TextField("Enter movie title", text: $movieTitle)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding()
            
            TextField("Enter filmmaker name", text: $filmmakerName)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .padding(.horizontal)

            Button(action: {
                if !movieTitle.isEmpty && !filmmakerName.isEmpty {
                    let newMovie = Movie(title: movieTitle, filmmaker: filmmakerName, backgroundColor: generateRandomPastelColor())
                    movies.append(newMovie)
                    movieTitle = ""  // Clear the text field
                    filmmakerName = ""
                    selectedTab = 0 // Switch to Home tab after adding the movie
                }
            }) {
                Text("Add Movie")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            .disabled(movieTitle.isEmpty || filmmakerName.isEmpty)
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
