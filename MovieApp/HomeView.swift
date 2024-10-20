import SwiftUI

struct HomeView: View {
    @Binding var movies: [Movie]  // Binding to the movies array

    var body: some View {
        NavigationView {
            VStack {
                if movies.isEmpty {
                    Text("No movies added yet!")
                        .foregroundColor(.gray)
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
                            ForEach(movies) { movie in
                                VStack {
                                    Rectangle()
                                        .fill(movie.backgroundColor)
                                        .frame(height: 180)
                                        .cornerRadius(12)
                                    Text(movie.title)
                                        .font(.caption)
                                        .padding(.top, 5)
                                }
                                .padding()
                            }
                        }
                    }
                }
            }
            .navigationTitle("Movies")
        }
    }
}
