import SwiftUI

struct HomeView: View {
    @Binding var movies: [Movie]
    @State private var movieToDelete: Movie?

    var body: some View {
        NavigationView {
            VStack {
                // Navigation indication
                HStack {
                    Spacer()
                    Image(systemName: "movieclapper.fill")
                        .font(.largeTitle) // Adjust the size as needed
                        .foregroundColor(.primary)
                    Spacer()
                }
                .padding(.vertical, 10)
                
                if movies.isEmpty {
                    Text("No movies added yet!")
                        .foregroundColor(.gray)
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            ForEach(movies) { movie in
                                ZStack {
                                    // Existing pastel rectangle
                                    Rectangle()
                                        .fill(movie.backgroundColor)
                                        .frame(height: 180)
                                        .cornerRadius(12)

                                    // Movie title and filmmaker name
                                    VStack {
                                        Text(movie.title)
                                            .font(.title2) // Larger font for the title
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                            .padding(.bottom, 4)

                                        Text(movie.filmmaker)
                                            .font(.subheadline) // Smaller font for the filmmaker
                                            .foregroundColor(.white.opacity(0.8))
                                            .multilineTextAlignment(.center)
                                    }

                                    // Delete button (X) in top-right corner
                                    Button(action: {
                                        movieToDelete = movie
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.white)
                                            .background(Circle().fill(Color.black.opacity(0.6)))
                                            .font(.title3)
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                    .padding(8)
                                }
                                .padding(.horizontal, 4)  // Reduce padding between cards
                            }
                        }
                        .padding(.horizontal, 8) // Reduce padding on grid edges
                    }
                }
            }
        }
        .confirmationDialog(
            "Are you sure you want to delete this movie?",
            isPresented: Binding(
                get: { movieToDelete != nil },
                set: { if !$0 { movieToDelete = nil } }
            ),
            titleVisibility: .visible
        ) {
            Button("Delete", role: .destructive) {
                if let movie = movieToDelete {
                    deleteMovie(movie)
                    movieToDelete = nil
                }
            }
            Button("Cancel", role: .cancel) {
                movieToDelete = nil
            }
        }
    }

    // Delete movie function
    private func deleteMovie(_ movie: Movie) {
        // Find and remove the movie from the array
        movies.removeAll { $0.id == movie.id }

        // Save the updated list to persistence
        PersistenceManager.shared.saveMovies(movies)
    }
}
