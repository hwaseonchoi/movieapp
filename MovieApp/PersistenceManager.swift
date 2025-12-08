import Foundation

class PersistenceManager {
    static let shared = PersistenceManager()

    private let moviesKey = "savedMovies"

    private init() {}

    // Save movies to UserDefaults
    func saveMovies(_ movies: [Movie]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(movies)
            UserDefaults.standard.set(data, forKey: moviesKey)
        } catch {
            print("Failed to save movies: \(error.localizedDescription)")
        }
    }

    // Load movies from UserDefaults
    func loadMovies() -> [Movie] {
        guard let data = UserDefaults.standard.data(forKey: moviesKey) else {
            return []
        }

        do {
            let decoder = JSONDecoder()
            let movies = try decoder.decode([Movie].self, from: data)
            return movies
        } catch {
            print("Failed to load movies: \(error.localizedDescription)")
            return []
        }
    }
}
