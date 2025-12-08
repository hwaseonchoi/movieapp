# MovieApp

A clean and simple iOS application for managing your personal movie collection. Built with Swift and SwiftUI, MovieApp lets you add movies to your collection and view them in an elegant grid layout.

## Features

- **Movie Collection Grid**: View all your movies in a beautiful 2-column grid layout with colorful cards
- **Add Movies**: Simple form to add new movies with title and filmmaker information
- **Visual Design**: Each movie card features a randomly-generated pastel background color
- **Tab Navigation**: Intuitive three-tab interface for easy navigation
- **Empty State**: Friendly message when no movies have been added yet

## Screenshots

The app features three main screens:
- **Home Tab**: Displays your movie collection in a grid layout
- **Add Movie Tab**: Form to add new movies to your collection
- **Profile Tab**: Placeholder for future user profile features

## Technologies

- **Language**: Swift
- **UI Framework**: SwiftUI
- **Architecture**: MVVM (Model-View-ViewModel)
- **Development Environment**: Xcode
- **Platform**: iOS

## Project Structure

```
movieapp/
├── MovieApp/
│   ├── MovieApp.swift           # App entry point
│   ├── ContentView.swift         # Main tab view container
│   ├── HomeView.swift            # Movie grid display
│   ├── AddMovieView.swift        # Add movie form
│   ├── Models/
│   │   └── Movie.swift           # Movie data model
│   └── Assets.xcassets/          # App assets and resources
├── MovieAppTests/                # Unit tests
└── MovieAppUITests/              # UI/Integration tests
```

## Data Model

The `Movie` struct contains:
- `id`: Unique identifier (UUID)
- `title`: Movie title
- `filmmaker`: Director or filmmaker name
- `backgroundColor`: Pastel color for card display

## Getting Started

### Prerequisites

- macOS with Xcode installed
- iOS Simulator or physical iOS device for testing

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd MovieApp
```

2. Open the project in Xcode:
```bash
open movieapp/MovieApp.xcodeproj
```

3. Select your target device (simulator or physical device)

4. Build and run the project:
   - Press `Cmd + R` or click the Run button in Xcode

## Usage

1. **Adding a Movie**:
   - Navigate to the "Add Movie" tab (plus icon)
   - Enter the movie title
   - Enter the filmmaker/director name
   - Tap "Add Movie"
   - The app automatically switches to the Home tab to show your new movie

2. **Viewing Your Collection**:
   - Open the Home tab (house icon)
   - Scroll through your movie collection
   - Each movie displays its title and filmmaker on a colorful card

## Technical Details

- Uses SwiftUI's `@State` and `@Binding` for state management
- Implements `LazyVGrid` for efficient scrolling performance
- Pastel colors generated using random RGB values in the 0.7-1.0 range
- Currently stores data in memory (no persistence layer)

## Current Limitations

- Movies are not persisted between app sessions
- No ability to edit or delete movies
- No search or filter functionality
- Profile tab is not yet implemented

## Future Improvements

Potential features for future development:
- [ ] Persistent storage (Core Data or SwiftData)
- [ ] Edit and delete movie functionality
- [ ] Search and filter capabilities
- [ ] Movie ratings and notes
- [ ] Categories or genres
- [ ] Movie poster images
- [ ] Sort options (by title, filmmaker, date added)
- [ ] Export/import movie collection
- [ ] Integration with movie databases (TMDb, IMDb)

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

## Author

Built with SwiftUI and Swift

---

Made with SwiftUI
