import Foundation

class TMDBService {
    static let shared = TMDBService()

    private init() {}

    // Search movies by title
    func searchMovies(query: String) async throws -> [TMDBMovie] {
        // URL encode the query
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            throw TMDBError.invalidQuery
        }

        // Construct the URL
        let urlString = "\(TMDBConfig.baseURL)/search/movie?api_key=\(TMDBConfig.apiKey)&query=\(encodedQuery)"
        guard let url = URL(string: urlString) else {
            throw TMDBError.invalidURL
        }

        // Make the request
        let (data, response) = try await URLSession.shared.data(from: url)

        // Check for HTTP errors
        guard let httpResponse = response as? HTTPURLResponse else {
            throw TMDBError.invalidResponse
        }

        guard httpResponse.statusCode == 200 else {
            throw TMDBError.httpError(statusCode: httpResponse.statusCode)
        }

        // Decode the response
        let decoder = JSONDecoder()
        let searchResponse = try decoder.decode(TMDBSearchResponse.self, from: data)

        return searchResponse.results
    }

    // Get full poster URL from poster path
    func getPosterURL(path: String) -> URL? {
        let urlString = "\(TMDBConfig.imageBaseURL)\(path)"
        return URL(string: urlString)
    }
}

// Custom errors
enum TMDBError: Error, LocalizedError {
    case invalidQuery
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int)
    case decodingError

    var errorDescription: String? {
        switch self {
        case .invalidQuery:
            return "Invalid search query"
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .httpError(let statusCode):
            return "Server error: \(statusCode)"
        case .decodingError:
            return "Failed to decode response"
        }
    }
}
