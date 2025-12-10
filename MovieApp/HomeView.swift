import SwiftUI

struct HomeView: View {
    @Binding var movies: [Movie]
    @State private var movieToDelete: Movie?
    @State private var movieToEdit: Movie?

    var body: some View {
        ZStack {
            if movies.isEmpty {
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "movieclapper.fill")
                            .font(.largeTitle)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding(.vertical, 10)

                    Spacer()
                    Text("No movies added yet!")
                        .foregroundColor(.gray)
                    Spacer()
                }
            } else {
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 0) {
                        HStack {
                            Spacer()
                            Image(systemName: "movieclapper.fill")
                                .font(.largeTitle)
                                .foregroundColor(.primary)
                            Spacer()
                        }
                        .padding(.vertical, 10)
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 1) {
                            ForEach(movies) { movie in
                                MovieCard(movie: movie, onEdit: {
                                    movieToEdit = movie
                                }, onDelete: {
                                    movieToDelete = movie
                                })
                            }
                        }
                        .padding(.horizontal, 12)
                        .padding(.bottom, 12)
                    }
                }
                .coordinateSpace(name: "scroll")
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
        .sheet(item: $movieToEdit) { movie in
            EditMovieView(
                movie: movie,
                movies: $movies,
                isPresented: Binding(
                    get: { movieToEdit != nil },
                    set: { if !$0 { movieToEdit = nil } }
                )
            )
        }
    }

    private func deleteMovie(_ movie: Movie) {
        movies.removeAll { $0.id == movie.id }
        PersistenceManager.shared.saveMovies(movies)
    }
}

// Extracted movie card as separate component
struct MovieCard: View {
    let movie: Movie
    let onEdit: () -> Void
    let onDelete: () -> Void

    var body: some View {
        ZStack {
            // Background
            if let posterPath = movie.posterPath,
               let posterURL = TMDBService.shared.getPosterURL(path: posterPath) {
                AsyncImage(url: posterURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width / 2 - 16, height: 270)
                            .clipped()
                    case .failure, .empty:
                        Rectangle()
                            .fill(movie.backgroundColor)
                            .frame(height: 270)
                    @unknown default:
                        Rectangle()
                            .fill(movie.backgroundColor)
                            .frame(height: 270)
                    }
                }
            } else {
                Rectangle()
                    .fill(movie.backgroundColor)
                    .frame(height: 270)
            }

            // Title and filmmaker for non-poster movies
            if movie.posterPath == nil {
                VStack {
                    Spacer()
                    Text(movie.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .padding(.bottom, 2)

                    Text(movie.filmmaker)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom, 12)
            }

            // Edit button
            Button(action: onEdit) {
                Image(systemName: "pencil.circle.fill")
                    .foregroundColor(.white)
                    .background(Circle().fill(Color.black.opacity(0.6)))
                    .font(.title3)
            }
            .buttonStyle(PlainButtonStyle())
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(8)
            .allowsHitTesting(true)

            // Delete button
            Button(action: onDelete) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.white)
                    .background(Circle().fill(Color.black.opacity(0.6)))
                    .font(.title3)
            }
            .buttonStyle(PlainButtonStyle())
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(8)
            .allowsHitTesting(true)
        }
        .frame(height: 270)
    }
}
