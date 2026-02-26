# Elevate Flower App 🌸

A comprehensive Flutter-based floral e-commerce platform that enables users to browse and purchase flowers, manage their orders, and save addresses. Built with modern Flutter architecture using BLoC pattern, clean architecture principles, and dependency injection.

## ✨ Features

- **User Authentication**
  - Login and signup functionality
  - Secure token storage with Flutter Secure Storage
  - Forget password and reset password features
  - OTP verification with Pinput

- **Shopping Experience**
  - Browse available flowers by categories and occasions
  - View best sellers and detailed product information
  - Advanced search and filter functionality
  - Shopping cart logic and order checkout
  - View past orders and order history

- **User Profile & Addresses**
  - Profile management and profile editing
  - Manage multiple delivery addresses
  - Google Maps integration for pinpointing address locations

- **Localization**
  - Multi-language support (English & Arabic)
  - RTL (Right-to-Left) support for Arabic
  - Custom fonts for each language

- **Responsive Design**
  - Adaptive UI for mobile devices
  - Screen size adaptation using ScreenUtil

## 📱 Tech Stack

### Core

- **Flutter SDK** >= 3.10.4
- **Dart** - Programming language

### State Management & Architecture

- **flutter_bloc** ^9.1.1 - BLoC pattern for state management
- **get_it** ^9.2.1 - Service locator for dependency injection
- **injectable** ^2.7.1+2 - Code generator for dependency injection
- **equatable** ^2.0.8 - Value equality

### Navigation

- **go_router** ^17.1.0 - Declarative routing

### Networking

- **dio** ^5.9.1 - HTTP client
- **retrofit** ^4.9.2 - Type-safe REST client
- **pretty_dio_logger** ^1.4.0 - Network request logging
- **internet_connection_checker_plus** ^2.9.1+2 - Network connectivity

### Local Storage

- **flutter_secure_storage** ^10.0.0 - Secure storage for sensitive data
- **shared_preferences** ^2.5.4 - Simple persistent storage
- **path_provider** ^2.1.5 - File system paths

### UI Components

- **flutter_screenutil** ^5.9.3 - Screen adaptation
- **cached_network_image** ^3.4.1 - Image caching
- **flutter_svg** ^2.2.3 - SVG rendering
- **lottie** ^3.3.2 - Animations
- **shimmer** ^3.0.0 - Loading effects
- **toastification** ^3.0.3 - Toast notifications
- **pinput** ^6.0.2 - OTP input widget

### Location & Maps

- **google_maps_flutter** ^2.14.2 - Maps support
- **geocoding** ^4.0.0 - Geocoding plugins
- **location** ^8.0.1 - Fetching current location

### Utilities

- **easy_localization** ^3.0.8 - Internationalization
- **image_picker** ^1.2.1 - Pick images from gallery/camera
- **logger** ^2.6.2 - Logging
- **json_annotation** ^4.11.0 - JSON serialization
- **firebase_core** - Firebase integration

### Dev Dependencies

- **build_runner** ^2.11.1 - Code generation
- **injectable_generator** any - DI code generation
- **json_serializable** ^6.13.0 - JSON serialization
- **retrofit_generator** ^10.2.3 - Retrofit code generation
- **flutter_launcher_icons** ^0.14.4 - App icon generation
- **flutter_lints** ^6.0.0 - Linting rules
- **mockito** ^5.6.3 - Testing framework

## � Prerequisites

Before you begin, ensure you have the following installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version >= 3.10.4)
- [Dart SDK](https://dart.dev/get-dart) (comes with Flutter)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/)
- [Xcode](https://developer.apple.com/xcode/) (for iOS development on macOS)
- A device or emulator for testing

## � Getting Started

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/ahmedalam782/elevate_flower_app.git
   cd elevate_flower_app
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Generate code**

   ```bash
   flutter pub run easy_localization:generate -S assets/localization -O lib/core/languages -f keys -o locale_keys.g.dart
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**

   ```bash
   # For development
   flutter run

   # For specific platform
   flutter run -d chrome        # Web
   flutter run -d android       # Android
   flutter run -d ios           # iOS
   ```

### Build for Production

```bash
# Android
flutter build apk --release
flutter build appbundle --release

# iOS
flutter build ios --release
```

## � Project Structure

```
lib/
├── core/                         # Core functionality
│   ├── api/                      # API tools and executer
│   ├── cache/                    # Local storage managers
│   ├── check_internet/           # Networking utilities
│   ├── constants/                # App-wide constants
│   ├── di/                       # Dependency injection setup
│   ├── errors/                   # Error handling & models
│   ├── languages/                # Localization logic
│   ├── routes/                   # Routing configuration
│   ├── theme/                    # Colors, typography, and assets
│   ├── utils/                    # General utilities
│   └── widget/                   # Reusable shared widgets
└── features/                     # Feature modules
    ├── splash/                   # App start splash screen
    ├── login/                    # Authentication (Login)
    ├── register/                 # Authentication (Signup)
    ├── forget_password/          # Forgot password flow
    ├── reset_password/           # Reset password
    ├── main_layout/              # Main app wrapper
    ├── home/                     # Home feed
    ├── categories/               # Browse categories
    ├── best_seller/              # Browse top items
    ├── occasions/                # Browse occasions
    ├── search/                   # Global search
    ├── filter/                   # Search filtering
    ├── product_details/          # Individual flower pages
    ├── cart/                     # Shopping cart
    ├── check_out/                # Outflow & logic
    ├── profile/                  # User profile display
    ├── edit_profile/             # Update user details
    ├── user_addresses/           # Manage multiple addresses
    ├── address_details/          # Google Maps address picker
    ├── orders_page/              # Order history display
    ├── change_lang/              # Switch application language
    └── terms_and_conditions/     # App terms
```

Each feature follows clean architecture with data, domain, and presentation boundaries.

## 🌍 Localization

The app supports multiple languages:

- English (en-US)
- Arabic (ar-EG)

Translation files are located in `assets/localization/`.

To add a new language:

1. Create a new JSON file in `assets/localization/` (e.g., `fr-FR.json`)
2. Add translations following the existing structure
3. Re-run easy_localization tool to inject them into the app

## 🎨 Assets

- **Images**: `assets/images/`
- **Icons**: `assets/icons/`
- **Animations**: `assets/animations/`
- **Fonts**: `assets/fonts/`
  - RobotoEnglish: Roboto (Light, Regular, Medium, SemiBold, Bold)
  - RobotoArabic: Roboto (Light, Regular, Medium, SemiBold, Bold)

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage
```

## 🔧 Development

### Code Generation

When you modify models or add new injectable dependencies:

```bash
# Watch for changes and rebuild automatically
flutter pub run build_runner watch

# One-time build
dart run build_runner build --delete-conflicting-outputs
```

### Linting

```bash
flutter analyze
```

### Format Code

```bash
flutter format .
```

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a new branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Commit your changes (`git commit -m 'Add some amazing feature'`)
5. Push to the branch (`git push origin feature/amazing-feature`)
6. Open a Pull Request

Please ensure your code:

- Follows the existing code style
- Includes appropriate tests
- Has proper documentation
- Passes all linting checks

## � License

This project is private and not published to pub.dev.

## 👤 Author

**Ahmed Alam**

- GitHub: [@ahmedalam782](https://github.com/ahmedalam782)

## 👥 Contributors

We appreciate all contributions to this project! Thank you to everyone who has helped make this project better.

- **[Ghazi-Mustafa](https://github.com/Ghazi-Mustafa)**
- **[MohammedGhazaly](https://github.com/MohammedGhazaly)**

## 📞 Support

For support, please open an issue in the GitHub repository.

---

Made with ❤️ using Flutter
