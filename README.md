# Custom Google Maps Flutter Application

A Flutter application that demonstrates advanced Google Maps integration with custom markers, POI (Points of Interest) navigation, and map controls.

## Features

- **Google Maps Integration**: Interactive map display with custom styling
- **Custom Markers**: Add and display POIs with custom marker icons
- **POI Navigation**: Navigate through saved points of interest with smooth camera animations
- **Map Type Toggle**: Switch between normal and satellite map views
- **Clean Architecture**: Organized codebase following clean architecture principles
- **State Management**: Efficient state handling using Flutter Bloc

## Project Structure

```
lib/
├── core/
│   └── utils/
│       └── permission_utils.dart
├── data/
│   ├── datasources/
│   │   └── map_data_source.dart
│   ├── models/
│   │   └── placemodel.dart
│   └── repositories/
│       └── map_repository_impl.dart
├── domain/
│   └── entities/
│       ├── place_entity.dart
│       └── poi_entity.dart
├── presentation/
│   ├── cubit/
│   │   ├── map_cubit.dart
│   │   └── map_state.dart
│   └── screens/
│       └── custom_google_map.dart
└── widgets/
    ├── add_poi_dialog.dart
    ├── google_map_view.dart
    ├── map_controls.dart
    └── poi_navigation_card.dart
```

## Technologies Used

- **Flutter**: UI framework for building natively compiled applications
- **Google Maps Flutter**: Official Google Maps SDK for Flutter
- **Flutter Bloc**: State management solution
- **Clean Architecture**: For separation of concerns and maintainable code

## Setup Instructions

1. Clone the repository
2. Add your Google Maps API key in:
   - Android: `android/app/src/main/AndroidManifest.xml`
   - iOS: `ios/Runner/AppDelegate.swift`
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the application:
   ```bash
   flutter run
   ```

## Assets

- Custom marker icons in `assets/images/`
- Map styling configuration in `assets/map_style/`

## Note

For security reasons, files containing sensitive information (such as API keys) are excluded from this repository. You must add your own Google Maps API key in the appropriate platform-specific files.

## Getting Help

- [Google Maps Flutter Plugin Documentation](https://pub.dev/packages/google_maps_flutter)
- [Flutter Documentation](https://docs.flutter.dev/)
- [Flutter Bloc Documentation](https://bloclibrary.dev/)
