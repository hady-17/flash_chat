# Flash Chat

Flash Chat is a simple, real-time chat example app built with Flutter. It's
designed as an educational project to demonstrate common patterns: navigation,
simple authentication flows, and chat UI design. The repository focuses on the
client-side Flutter implementation; a backend (e.g., Firebase) can be added to
enable persistent authentication and real-time messaging.

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Quick setup (Windows PowerShell)](#quick-setup-windows-powershell)
- [Run & test](#run--test)
- [Build & release notes](#build--release-notes)
- [Optional: Firebase quick-start](#optional-firebase-quick-start)
- [Project structure](#project-structure)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## Features

- Simple email/password registration and login UI (example flow inside the app).
- Chat UI: list of messages and message bubbles with basic theming.
- Cross-platform UI (Android, iOS, web, desktop) using Flutter.

## Requirements

- Flutter SDK (see `pubspec.yaml` for the minimum SDK constraint):
	- This project specifies SDK >= 3.9.2. Install Flutter from
		https://docs.flutter.dev/get-started/install
- A working device or emulator for your target platform (Android/iOS/Windows).
- Git (optional, for cloning the repository).

## Quick setup (Windows PowerShell)

1. Clone the repo and fetch dependencies

```powershell
git clone https://github.com/hady-17/flash_chat.git
cd flash_chat
flutter pub get
```

2. Verify installation

```powershell
flutter doctor
```

3. Run the app

List available devices and run on a device/emulator:

```powershell
flutter devices
flutter run -d <device-id>
```

To run on Windows desktop (when desktop support is enabled):

```powershell
flutter run -d windows
```

Tip: If the app fails to start, run `flutter clean; flutter pub get` and try
again.

## Run & test

- Run unit/widget tests with:

```powershell
flutter test
```

- Run the analyzer / lints (from repo root):

```powershell
flutter analyze
```

## Build & release notes

- Android (release):

```powershell
flutter build apk --release
```

- iOS (release):

Follow Flutter's official iOS release docs. You will need a macOS machine
with Xcode.

- Web:

```powershell
flutter build web
```

Note: For production-ready release builds you should:

- Add environment configs for API keys and backend URLs.
- Replace the example/local auth flows with a secure authentication backend.

## Optional: Firebase quick-start

This repository does not include Firebase wiring out of the box. To add
Firestore and Firebase Authentication as an example backend:

1. Create a Firebase project at https://console.firebase.google.com
2. Add Android/iOS/web apps in the Firebase console and download the
	 configuration files (`google-services.json` for Android, `GoogleService-Info.plist` for iOS).
3. Add the FlutterFire packages to `pubspec.yaml` (example):

```yaml
dependencies:
	firebase_core: ^2.0.0
	firebase_auth: ^4.0.0
	cloud_firestore: ^4.0.0
```

4. Initialize Firebase in `main.dart` before running the app:

```dart
import 'package:firebase_core/firebase_core.dart';

void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	await Firebase.initializeApp();
	runApp(MyApp());
}
```

5. Replace the local auth and message storage with `firebase_auth` and
	 `cloud_firestore` calls in the `registration_screen.dart`, `login_screen.dart`,
	 and `chat_screen.dart` files.

Refer to the FlutterFire docs for detailed platform-specific steps:
https://firebase.flutter.dev/docs/overview

## Project structure

- `lib/` - main app code
	- `main.dart` - app entry
	- `constants.dart` - app-wide constants
	- `screens/` - individual screens (`welcome_screen.dart`,
		`registration_screen.dart`, `login_screen.dart`, `chat_screen.dart`)
- `images/` - image assets used by the app (add screenshots here)
- `android/`, `ios/`, `web/`, `windows/`, `macos/`, `linux/` - platform folders
- `test/` - widget/unit tests

## Troubleshooting

- If `flutter pub get` fails: check your internet connection and SDK
	version, then run `flutter pub cache repair`.
- If platform-specific build errors occur, run `flutter doctor -v` and follow
	the suggested fixes.
- If you add Firebase and see initialization errors, ensure platform
	configuration files are correctly added and that you re-run `flutter pub get`.

## Contributing

Contributions are welcome. Recommended workflow:

1. Fork the repository and create a feature branch: `git checkout -b feat/my-change`.
2. Make small, focused commits and add tests where applicable.
3. Open a pull request with a clear description of what the change does and
	 why it's needed.

Please open an issue to propose larger changes before implementing them.

## License

This project does not currently include a license file. If you want to make
this project open source, add a `LICENSE` file in the repository root. A
common choice is the MIT license for small sample projects.

---

If you'd like, I can now:
- Add an example `google-services.json` template and instructions for Android.
- Create a small branch that wires Firebase Auth + Firestore to the existing
	screens (example implementation).
- Add README badges and CI configuration for automated tests.

## Changes made in this repository

This fork has several small, practical modifications to make the example app
runnable and easier to develop. If you update the project from another
upstream source, these are the local changes you should be aware of:

- Firebase initialization
	- `lib/main.dart` now calls `WidgetsFlutterBinding.ensureInitialized()` and
		`await Firebase.initializeApp()` so Firebase APIs can be used safely.

- Android / Gradle fixes
	- Adjusted `android/app/build.gradle.kts` and `android/build.gradle.kts` to
		ensure the project builds and the Android package name matches the
		generated `MainActivity`.
	- The Google Services Gradle plugin is configured for Firebase usage; if you
		add `google-services.json`, the plugin will wire the native config.

- Package name alignment
	- The Android applicationId/namespace was corrected to match
		`android/app/src/main/kotlin/.../MainActivity.kt` so the app no longer
		crashes at startup with a missing `MainActivity`.

- Password field reliability
	- `lib/components/pass_field.dart` accepts an optional
		`TextEditingController` and the registration screen (`registration_screen.dart`)
		now uses a controller so the password value is always available when the
		Register button is pressed.

- Authentication persistence guidance
	- The README and code include a recommended pattern (AuthGate using
		`FirebaseAuth.instance.authStateChanges()`) so the app automatically shows
		the right screen when a user is already signed in.

- Logout/navigation behavior
	- The Chat screen logout button now awaits sign out and uses
		`Navigator.pushNamedAndRemoveUntil(..., (r) => false)` so the user cannot
		navigate back to the chat after logging out.

- Tests
	- Added widget tests in `test/widget_test.dart` covering all screens and
		components (Welcome, Login, Registration, Btn, PassField and a message
		input row). Tests avoid initializing Firebase/Firestore; Firestore usage
		is exercised in app runtime only.

If you'd like I can also:
- Add a small CI workflow to run `flutter analyze` + `flutter test` on PRs.
- Add a `firebase_options.dart` via FlutterFire CLI and a branch that wires
	authentication end-to-end (Auth + Firestore demo messages).

