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
                        .font(.system(.subheadline, design: .serif, weight: .semibold))
                        .foregroundColor(.black.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .padding(.bottom, 2)

                    Text(movie.filmmaker)
                        .font(.caption)
                        .foregroundColor(.black.opacity(0.65))
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom, 12)
            }

            // Actions menu (edit / delete)
            Menu {
                Button(action: onEdit) {
                    Label("Edit", systemImage: "pencil")
                }
                Button(role: .destructive, action: onDelete) {
                    Label("Delete", systemImage: "trash")
                }
            } label: {
                Image(systemName: "ellipsis")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 28, height: 28)
                    .background(Circle().fill(Color.black.opacity(0.38)))
                    .contentShape(Circle())
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(8)
        }
        .frame(height: 270)
    }
}
