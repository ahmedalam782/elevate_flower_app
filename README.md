# Elevate Flower App 🌸

Welcome to the **Elevate Flower App**! This is a comprehensive Flutter mobile application designed for floral e-commerce.

## 🚀 Features & Technologies

This project applies modern Flutter development practices and architecture:

- **State Management:** `flutter_bloc`
- **Routing:** `go_router` for declarative routing.
- **Dependency Injection:** `get_it` combined with `injectable` and `injectable_generator`.
- **Networking:** `dio` paired with `retrofit` for a clean, code-generated API client.
- **Localization:** `easy_localization` (English and Arabic `ar-EG` supported).
- **Firebase Integration:** `firebase_analytics`, `firebase_crashlytics`, and `firebase_messaging` for tracking, stability, and push notifications.
- **Maps & Geolocation:** `google_maps_flutter`, `geocoding`, and `location`.
- **UI/UX Enhancements:** `flutter_screenutil` for responsive design, `lottie` for animations, `flutter_svg` for vector graphics, and `shimmer` for loading effects.
- **CI/CD:** Automated builds, unit tests, and distribution via GitHub Actions (`wzieba/Firebase-Distribution-Github-Action`).

## 🛠️ Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Version `3.41.2` recommended)
- [Dart SDK](https://dart.dev/get-dart)
- Android Studio / VS Code / IntelliJ
- An active Firebase project (for Crashlytics, Analytics, and Messaging)

## 📦 Getting Started

1.  **Clone the Repository**

    ```sh
    git clone https://github.com/your-username/elevate_flower_app.git
    cd elevate_flower_app
    ```

2.  **Install Dependencies**

    ```sh
    flutter pub get
    ```

3.  **Run Code Generation**
    This project heavily relies on code generation for API clients, localization, and dependency injection.

    ```sh
    flutter pub run easy_localization:generate -S assets/localization -O lib/core/languages -f keys -o locale_keys.g.dart
    dart run build_runner build --delete-conflicting-outputs
    ```

4.  **Run the App**
    ```sh
    flutter run
    ```

## 📂 Project Structure

The codebase is structured into features and core utilities to ensure separation of concerns and maintainability. It follows a Clean Architecture approach heavily utilizing BLoC and Repository patterns.

## 🧪 Testing

The repository runs automated tests via GitHub Actions. If you want to run them locally:

```sh
flutter test
```

## 📝 License

This project is proprietary and confidential.
