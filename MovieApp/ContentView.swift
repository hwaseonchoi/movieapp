//
//  ContentView.swift
//  MovieApp
//
//  Created by Roxane Choi on 20/10/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var movies: [Movie] = []  // Store the list of movies

    var body: some View {
        TabView(selection: $selectedTab) {
            // Home View
            HomeView(movies: $movies) // Pass the movies array to HomeView
                .tabItem {
                   Image(systemName: "house.circle")
                }
                .tag(0)

            // Gallery View
            GalleryView(movies: $movies)
                .tabItem {
                    Image(systemName: "square.grid.3x3")
                }
                .tag(1)

            // Add Movie View
            AddMovieView(movies: $movies, selectedTab: $selectedTab) // Pass selectedTab to AddMovieView array to AddMovieView
                .tabItem {
                   Image(systemName: "plus.circle")
                }
                .tag(2)

            // Profile tab
            Text("Profile View")
                .tabItem {
                    Image(systemName: "person.circle")
                }
                .tag(3)
        }
        .onAppear {
            // Load saved movies when app starts
            movies = PersistenceManager.shared.loadMovies()
        }
    }
}

#Preview {
    ContentView()
}
