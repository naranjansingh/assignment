# Settings App (Flutter UI Assignment)

This repository contains the Flutter implementation of the provided Figma design for the Flutter Developer Assignment. The application closely replicates the UI with pixel-perfect accuracy, responsive layouts, smooth animations, and interactive navigation flows while maintaining a clean, modular, and maintainable codebase.

## 🚀 Project Setup

Follow these instructions to run the application on your local machine:

1. **Clone the repository:**
   ```bash
   git clone <REPOSITORY_URL>
   cd adventurous-davinci
   ```

2. **Fetch dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the application:**
   Ensure you have a connected device or a running emulator/simulator.
   ```bash
   flutter run
   ```

## 🛠 Requirements

- **Flutter SDK:** version 3.6.1 or newer.
- **Dart SDK:** compatible with Flutter 3.6.1 (e.g. ^3.6.1).
- Android Studio or Xcode (for building to Android or iOS).

## 📦 Build Instructions

To generate the Android APK for release:

1. Navigate to the project root directory.
2. Run the following command:
   ```bash
   flutter build apk --release
   ```
3. The generated APK will be located at:
   `build/app/outputs/flutter-apk/app-release.apk`

## 📚 Third-Party Packages

The following external packages were used in this project to adhere to Flutter best practices while avoiding unnecessary bloat:

- **[`provider`](https://pub.dev/packages/provider):** Used for state management and view-model architecture to keep UI and business logic cleanly separated (e.g., managing selected tabs, screen navigation, drawer toggling).
- **[`google_fonts`](https://pub.dev/packages/google_fonts):** Used to easily apply standard modern typography that matches the Figma design without manually importing font files.
- **[`intl`](https://pub.dev/packages/intl):** Utilized for proper date formatting in the calendar screen (e.g. converting `DateTime` objects into strings like "Mon, Oct 24 - Wed, Oct 26").
- **[`cupertino_icons`](https://pub.dev/packages/cupertino_icons):** Default icon set required by Flutter for iOS-style icons.

## 📌 Assumptions & Deviations

- **Asset Availability:** The generic `assets/images` directory (such as `avatar.jpg`, `hotel_1.jpg`) was used since original Figma high-resolution image exports were not explicitly provided.
- **Custom Drawer Animation:** The 3D scaling/zooming drawer animation was implemented using `AnimatedContainer` and `Transform` APIs to exactly replicate the feeling of the Figma design.
- **Interactive vs Static UI:** Some areas of the Figma design displayed a static mockup (e.g., a static calendar grid starting from 1 to 31). The implementation provides a fully functional and animated layout (swiping between months, range selection showing continuous pills) while preserving the exact layout, colors, and styling from the static reference.
- **App Name:** The project was initialized as `settings_app` internally as per the pubspec file, though it behaves as a travel/booking application.
