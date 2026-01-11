
# Driver Task

## Purpose of the Application

Driver Task is a mobile application for couriers/drivers to manage their delivery tasks. Users can list their assigned delivery tasks, view details, track routes on the map, and manage the delivery process. The app provides features such as starting tasks, marking them as failed, and scanning packages via barcode.

## Technologies and Packages Used

- **Flutter**: Main framework
- **State Management**: `bloc`, `flutter_bloc`
- **Network**: `dio`, `equatable`
- **UI**: `flutter_screenutil`, `lottie`, `flutter_svg`, `shimmer`, `flutter_staggered_animations`
- **Localization**: `easy_localization`, `intl`, `flutter_localizations`
- **Router**: `go_router`
- **Map**: `google_maps_flutter`, `geolocator`, `geocoding`, `google_polyline_algorithm`
- **Dependency Injection**: `get_it`
- **Barcode/QR Scanner**: `mobile_scanner`
- **Environment Variables**: `flutter_dotenv`
- **Error Handling**: `either_dart`

## Main Features

- Task list and details
- Start, fail, and scan tasks
- Route and location tracking with Google Maps
- Package verification via barcode/QR code
- Multi-language support (TR, EN, RU, AZ)
- Modern and animated user interface

## Project Architecture

- **Feature-based** folder structure (features, core, shared)
- Bloc-based state management
- Service and repository layers for separated business logic
- Modular and scalable structure

## Screenshot / Demo Video

The following video demonstrates the general workflow of the application:

## 📲 App Demo

[▶️ Click here to watch the full app demo video](https://firebasestorage.googleapis.com/v0/b/mono-e4a22.appspot.com/o/app_review.mp4?alt=media&token=1db169fc-68c1-40f8-9013-5e693176e903)



> If the video does not play, open `assets/videos/review.mp4` manually.

## Installation and Running

1. Install dependencies:
	```sh
	flutter pub get
	```
2. Add environment files (.env) and required API keys.
3. Run the application:
	```sh
	flutter run
	```

## License

MIT
