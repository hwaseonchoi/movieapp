import SwiftUI

struct GalleryView: View {
    @Binding var movies: [Movie]

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 8)

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(movies) { movie in
                        let posterURL = movie.posterPath.map { "https://image.tmdb.org/t/p/w500\($0)" } ?? ""
                        AsyncImage(url: URL(string: posterURL)) { phase in
                            switch phase {
                            case .empty:
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .aspectRatio(2/3, contentMode: .fit)
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(2/3, contentMode: .fill)
                            case .failure:
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .aspectRatio(2/3, contentMode: .fit)
                                    .overlay(
                                        Image(systemName: "photo")
                                            .foregroundColor(.gray)
                                    )
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                }
            }
            .navigationTitle("Gallery")
        }
    }
}

#Preview {
    GalleryView(movies: .constant([
        Movie(title: "Test Movie", filmmaker: "Director", backgroundColor: .blue)
    ]))
}
