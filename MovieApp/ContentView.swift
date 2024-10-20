//
//  ContentView.swift
//  MovieApp
//
//  Created by Roxane Choi on 20/10/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var movies: [Movie] = []  // Store the list of movies
    var body: some View {
        TabView {
                // Home View
                   HomeView(movies: $movies) // Pass the movies array to HomeView
                       .tabItem {
                           Image(systemName: "house.circle.fill") // Home icon
                           Text("Home") // Optional label
                       }
                   
                   // Add Movie View
                   AddMovieView(movies: $movies) // Pass the movies array to AddMovieView
                       .tabItem {
                           Image(systemName: "plus.circle.fill") // Add Movie icon
                           Text("Add Movie") // Optional label
                       }
                    
                    // Profile tab
                    Text("Profile View")
                        .tabItem {
                            Image(systemName: "person.circle.fill") // Profile icon
                        }
                }
    }
}

#Preview {
    ContentView()
}
