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
                                }
                                .padding(.horizontal, 4)  // Reduce padding between cards
                            }
                        }
                        .padding(.horizontal, 8) // Reduce padding on grid edges
                    }
                }
            }
            .navigationTitle("Movies")
        }
    }
}
