import SwiftUI

struct AddMovieView: View {
    @Binding var movies: [Movie]
    @Binding var selectedTab: Int

    @State private var searchQuery: String = ""
    @State private var searchResults: [TMDBMovie] = []
    @State private var isSearching = false
    @State private var errorMessage: String?
    @State private var selectedMovie: TMDBMovie?
    @State private var filmmakerName: String = ""
    @State private var showManualEntry = false

    // View modes
    enum ViewMode {
        case search
        case confirmSelection
        case manualEntry
    }
    @State private var currentMode: ViewMode = .search

    var body: some View {
        VStack {
            switch currentMode {
            case .search:
                searchView
            case .confirmSelection:
                confirmSelectionView
            case .manualEntry:
                manualEntryView
            }
        }
        .padding()
    }

    // MARK: - Search View
    private var searchView: some View {
        VStack(spacing: 16) {
            Text("Search Movie")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)

            // Search field
            TextField("Enter movie title...", text: $searchQuery)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .onChange(of: searchQuery) { oldValue, newValue in
                    // Debounce search (simple version)
                    Task {
                        try? await Task.sleep(nanoseconds: 500_000_000) // 0.5s
                        if !newValue.isEmpty {
                            await performSearch()
                        }
                    }
                }

            // Loading indicator
            if isSearching {
                ProgressView("Searching...")
                    .padding()
            }

            // Error message
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding()
            }

            // Search results
            if !searchResults.isEmpty {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(searchResults) { movie in
                            SearchResultRow(movie: movie) {
                                selectedMovie = movie
                                currentMode = .confirmSelection
                            }
                        }
                    }
                }
            } else if !isSearching && !searchQuery.isEmpty && errorMessage == nil {
                Text("No results found")
                    .foregroundColor(.gray)
                    .padding()
            }

            Spacer()

            // Manual entry button
            Button(action: {
                currentMode = .manualEntry
            }) {
                HStack {
                    Image(systemName: "plus.circle")
                    Text("Add Movie Manually")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.2))
                .foregroundColor(.primary)
                .cornerRadius(8)
            }
        }
    }

    // MARK: - Confirm Selection View
    private var confirmSelectionView: some View {
        VStack(spacing: 16) {
            if let movie = selectedMovie {
                Text("Add Movie")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top)

                // Movie poster preview
                if let posterPath = movie.posterPath,
                   let posterURL = TMDBService.shared.getPosterURL(path: posterPath) {
                    AsyncImage(url: posterURL) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200)
                                .cornerRadius(8)
                        case .failure, .empty:
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: 200)
                                .cornerRadius(8)
                        @unknown default:
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: 200)
                                .cornerRadius(8)
                        }
                    }
                }

                // Movie title (pre-filled)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Title")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(movie.title)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }

                // Year (if available)
                if let year = movie.year {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Year")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(year)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                    }
                }

                // Filmmaker input (optional)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Filmmaker/Director (Optional)")
                        .font(.caption)
                        .foregroundColor(.gray)
                    TextField("Enter filmmaker name (optional)", text: $filmmakerName)
                        .autocapitalization(.words)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }

                Spacer()

                // Action buttons
                HStack(spacing: 12) {
                    // Cancel button
                    Button(action: {
                        currentMode = .search
                        filmmakerName = ""
                        selectedMovie = nil
                    }) {
                        Text("Back")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(.primary)
                            .cornerRadius(8)
                    }

                    // Add button (always enabled)
                    Button(action: {
                        addTMDBMovie(movie)
                    }) {
                        Text("Add Movie")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
        }
    }

    // MARK: - Manual Entry View
    private var manualEntryView: some View {
        VStack(spacing: 16) {
            Text("Add Movie Manually")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)

            TextField("Enter movie title", text: $searchQuery)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)

            TextField("Enter filmmaker name", text: $filmmakerName)
                .autocapitalization(.words)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)

            Spacer()

            HStack(spacing: 12) {
                // Cancel button
                Button(action: {
                    currentMode = .search
                    searchQuery = ""
                    filmmakerName = ""
                }) {
                    Text("Back")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.2))
                        .foregroundColor(.primary)
                        .cornerRadius(8)
                }

                // Add button
                Button(action: {
                    addManualMovie()
                }) {
                    Text("Add Movie")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(searchQuery.isEmpty || filmmakerName.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(searchQuery.isEmpty || filmmakerName.isEmpty)
            }
        }
    }

    // MARK: - Helper Functions
    private func performSearch() async {
        guard !searchQuery.isEmpty else { return }

        isSearching = true
        errorMessage = nil

        do {
            let results = try await TMDBService.shared.searchMovies(query: searchQuery)
            await MainActor.run {
                searchResults = results
                isSearching = false
            }
        } catch {
            await MainActor.run {
                errorMessage = "Failed to search: \(error.localizedDescription)"
                isSearching = false
                searchResults = []
            }
        }
    }

    private func addTMDBMovie(_ tmdbMovie: TMDBMovie) {
        let newMovie = Movie(
            title: tmdbMovie.title,
            filmmaker: filmmakerName.isEmpty ? "Unknown" : filmmakerName,
            backgroundColor: generateRandomPastelColor(),
            posterPath: tmdbMovie.posterPath,
            tmdbId: tmdbMovie.id,
            year: tmdbMovie.year
        )

        movies.append(newMovie)
        PersistenceManager.shared.saveMovies(movies)

        // Reset and switch to home
        searchQuery = ""
        filmmakerName = ""
        selectedMovie = nil
        currentMode = .search
        selectedTab = 0
    }

    private func addManualMovie() {
        let newMovie = Movie(
            title: searchQuery,
            filmmaker: filmmakerName,
            backgroundColor: generateRandomPastelColor()
        )

        movies.append(newMovie)
        PersistenceManager.shared.saveMovies(movies)

        // Reset and switch to home
        searchQuery = ""
        filmmakerName = ""
        currentMode = .search
        selectedTab = 0
    }

    private func generateRandomPastelColor() -> Color {
        return Color(
            red: Double.random(in: 0.7...1.0),
            green: Double.random(in: 0.7...1.0),
            blue: Double.random(in: 0.7...1.0)
        )
    }
}

// MARK: - Search Result Row
struct SearchResultRow: View {
    let movie: TMDBMovie
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                // Poster thumbnail
                if let posterPath = movie.posterPath,
                   let posterURL = TMDBService.shared.getPosterURL(path: posterPath) {
                    AsyncImage(url: posterURL) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 90)
                                .cornerRadius(8)
                                .clipped()
                        case .failure, .empty:
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 60, height: 90)
                                .cornerRadius(8)
                        @unknown default:
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 60, height: 90)
                                .cornerRadius(8)
                        }
                    }
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 60, height: 90)
                        .cornerRadius(8)
                }

                // Movie info
                VStack(alignment: .leading, spacing: 4) {
                    Text(movie.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(2)

                    if let year = movie.year {
                        Text(year)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    if let overview = movie.overview, !overview.isEmpty {
                        Text(overview)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .lineLimit(2)
                    }
                }

                Spacer()
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
