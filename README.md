# MovieApp

A clean and simple iOS application for managing your personal movie collection and share with your friends. Built with Swift and SwiftUI, MovieApp lets you search for movies using the TMDB API, add them to your collection with poster images, and manage them with full CRUD operations.

## Features

- 🎬 **Movie Search**: Search movies using The Movie Database (TMDB) API
- 🖼️ **Poster Images**: Display movie posters fetched from TMDB
- ➕ **Add Movies**: Add movies to your personal collection
- ✏️ **Edit Movies**: Update movie information
- 🗑️ **Delete Movies**: Remove movies with confirmation dialog
- 💾 **Data Persistence**: Movies are saved using UserDefaults

## Screenshots

The app features four main screens:
- **Home Tab**: Displays your movie collection in a grid layout with posters
- **Gallery Tab**: Compact 8-column tile view showing only posters for quick browsing
- **Add Movie Tab**: Search and add new movies to your collection
- **Profile Tab**: Placeholder for future user profile features

## Technologies

- **Language**: Swift
- **UI Framework**: SwiftUI
- **Architecture**: MVVM (Model-View-ViewModel)
- **API**: The Movie Database (TMDB) API
- **Data Persistence**: UserDefaults
- **Development Environment**: Xcode
- **Platform**: iOS

## Project Structure

```
MovieApp/
├── README.md                      # Project documentation
├── MovieApp.xcodeproj/            # Xcode project file
├── MovieApp/
│   ├── MovieApp.swift             # App entry point
│   ├── ContentView.swift          # Main tab view container
│   ├── HomeView.swift             # Movie grid display
│   ├── GalleryView.swift          # Compact tile gallery view
│   ├── AddMovieView.swift         # Add movie form with search
│   ├── EditMovieView.swift        # Edit movie form
│   ├── Config.swift               # Configuration settings
│   ├── Config.swift.example       # Example configuration file
│   ├── Models/
│   │   ├── Movie.swift            # Movie data model
│   │   └── TMDBModels.swift       # TMDB API response models
│   ├── Services/
│   │   ├── TMDBService.swift      # TMDB API service
│   │   └── PersistenceManager.swift # Data persistence service
│   ├── Assets.xcassets/           # App assets and resources
│   └── Preview Content/           # Preview assets for SwiftUI
├── MovieAppTests/                 # Unit tests
└── MovieAppUITests/               # UI/Integration tests
```

## Data Model

The `Movie` struct contains:
- `id`: Unique identifier (UUID)
- `title`: Movie title
- `filmmaker`: Director or filmmaker name
- `posterURL`: URL to movie poster image from TMDB
- `backgroundColor`: Pastel color for card display

## Getting Started

### Prerequisites

- macOS with Xcode installed
- iOS Simulator or physical iOS device for testing
- TMDB API key (for movie search functionality)

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd MovieApp
```

2. Set up TMDB API:
   - Get your API key from [The Movie Database](https://www.themoviedb.org/settings/api)
   - Add your API key to the project configuration

3. Open the project in Xcode:
```bash
open MovieApp.xcodeproj
```

4. Select your target device (simulator or physical device)

5. Build and run the project:
   - Press `Cmd + R` or click the Run button in Xcode

## Usage

1. **Searching for Movies**:
   - Navigate to the "Add Movie" tab (plus icon)
   - Use the search functionality to find movies via TMDB
   - Select a movie to add it to your collection

2. **Adding a Movie**:
   - Search and select a movie, or manually enter details
   - Movie poster is automatically fetched from TMDB
   - The app automatically switches to the Home tab to show your new movie

3. **Viewing Your Collection**:
   - Open the Home tab (house icon)
   - Scroll through your movie collection in a grid layout
   - Each movie displays its poster, title, and filmmaker on a colorful card

4. **Gallery View**:
   - Open the Gallery tab (grid icon)
   - Browse your entire collection in a compact 8-column tile layout
   - Only posters are shown for quick visual scanning
   - Perfect for getting an overview of your collection

5. **Editing a Movie**:
   - Tap on a movie card to edit its details
   - Update title, filmmaker, or other information
   - Changes are automatically saved

6. **Deleting a Movie**:
   - Swipe or tap delete on a movie card
   - Confirm deletion in the dialog
   - Movie is permanently removed from your collection

## Future Improvements

Potential features for future development:
- [ ] User authentication (sign in / sign up)
- [ ] User profile management
- [ ] Movie ratings and notes
- [ ] Categories or genres
- [ ] Advanced search and filter capabilities
- [ ] Sort options (by title, filmmaker, date added, rating)
- [ ] Export/import movie collection
- [ ] Cloud sync across devices
- [ ] Share movie lists with friends
- [ ] Movie trailers and reviews
- [ ] Watchlist functionality

## Testing

The project includes:
- Unit tests in `MovieAppTests/`
- UI tests in `MovieAppUITests/`

Run tests in Xcode:
- Press `Cmd + U` or select Product > Test from the menu

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is available for personal and educational use.
