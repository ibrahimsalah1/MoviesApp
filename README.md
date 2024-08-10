# Movies App

The Movie App is an iOS application that enables users to effortlessly browse and search for movies. It is built upon a robust Clean Architecture and leverages the MVVM (Model-View-ViewModel) pattern in the presentation layer, ensuring a well-structured and maintainable codebase. The app also features a caching repository that utilizes Core Data for efficient data persistence, providing users with a seamless and responsive experience

## Features

- Browse movies list
- Search for movies by title
- Filter movies by genres
- View more details about the movie
- Movies list works in online and offline states

## Architecture

The application is structured using the following modules:

1. **NetworkLayer**: Handles all network-related tasks, such as making API requests and handling responses.
2. **DataLayer**: Contains the application's core business logic and entities.
3. **Router**: Responsible for navigating between screens in the SwiftUI-based user interface using **(NavigationStack)**
4. **Movies Feature**: Implements the main functionality of the app, including browsing, searching, and viewing movie details.
5. **Presentation layer**: SwiftUI + MVVM-C

The application also uses a caching repository that leverages Core Data for offline data storage and retrieval.

As a clean architecture, I should add use cases for production and large-scaling apps but for now, I keep it simple.

## Need to enhance
- Use cases to isolate Business Logic, but for now, I keep it simple.
- Add a DesignSystem module for shared application UI components like colors in the current state.
- Add unit tests for movie details and cashing layer
- Enhance cashing for movies with core data to be a more generic data provider.
- Add mocks dependencies to enable SwiftUI Previews


## Requirements
- Xcode 15.4+
- iOS 16+

## Getting Started

To run the application, follow these steps:

1. Clone the repository: `https://github.com/ibrahimsalah1/MoviesApp`
2. Open the project in Xcode.
3. Build and run the application on your desired iOS device or simulator.

## Dependencies

- [SDWebImageSwiftUI](https://github.com/SDWebImage/SDWebImageSwiftUI) for image loading and caching
- [Core Data](https://developer.apple.com/documentation/coredata) for local data storage

## Preview
https://github.com/user-attachments/assets/055cdbcc-1a56-435d-a199-80722c9948ab

