import SwiftUI

struct HomeView: View {
    @Binding var movies: [Movie]

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
                                ZStack {
                                    // Existing pastel rectangle
                                    Rectangle()
                                        .fill(movie.backgroundColor)
                                        .frame(height: 180)
                                        .cornerRadius(12)
                                    
                                    // Title displayed on top of the rectangle
                                    Text(movie.title)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding(8)
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
