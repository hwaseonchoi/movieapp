import SwiftUI

struct EditMovieView: View {
    let movie: Movie
    @Binding var movies: [Movie]
    @Binding var isPresented: Bool

    @State private var movieTitle: String
    @State private var filmmakerName: String

    init(movie: Movie, movies: Binding<[Movie]>, isPresented: Binding<Bool>) {
        self.movie = movie
        self._movies = movies
        self._isPresented = isPresented
        // Initialize with existing values
        self._movieTitle = State(initialValue: movie.title)
        self._filmmakerName = State(initialValue: movie.filmmaker)
    }

    var body: some View {
        NavigationView {
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
                        // Find and update the movie in the array
                        if let index = movies.firstIndex(where: { $0.id == movie.id }) {
                            movies[index].title = movieTitle
                            movies[index].filmmaker = filmmakerName

                            // Save movies to persistence
                            PersistenceManager.shared.saveMovies(movies)
                        }

                        // Dismiss the sheet
                        isPresented = false
                    }
                }) {
                    Text("Save Changes")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(movieTitle.isEmpty || filmmakerName.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
                .disabled(movieTitle.isEmpty || filmmakerName.isEmpty)

                Spacer()
            }
            .padding()
            .navigationTitle("Edit Movie")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
            }
        }
    }
}
