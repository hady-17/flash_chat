# flash_chat

# Flash Chat

Flash Chat is a simple, real-time chat app built with Flutter. It's intended as
an educational example demonstrating basic Flutter app structure, navigation,
authentication flow, and chat UI patterns. The app includes screens for
welcome, registration, login, and a live chat interface.

## Features

- Email/password registration and login UI (local example flow).
- Real-time chat UI with message list and message bubbles.
- Basic assets and theming (Material design).
- Cross-platform: Android, iOS, web, desktop (standard Flutter targets).

> Note: This repository provides the app structure and UI. If you want a
> production-ready backend (e.g., Firebase Auth / Firestore), you can add it
> and wire the authentication and messaging code into the existing screens.

## Tech stack

- Flutter (Dart), compatible with SDK >= 3.9.2 (see `pubspec.yaml`).
- Uses Material Design and the `cupertino_icons` package for platform icons.

## Screenshots

Add screenshots to the `images/` folder and reference them here. For example,
place `welcome.png` or other screen captures into `images/` and insert the
corresponding markdown image links.

## Quick setup (Windows PowerShell)

1. Prerequisites

- Install Flutter: https://docs.flutter.dev/get-started/install
- Make sure `flutter` is on your PATH and `flutter doctor` is green.

2. Clone & install dependencies

```powershell
git clone https://github.com/hady-17/flash_chat.git
cd flash_chat
flutter pub get
```

3. Run on an emulator or device

List devices and pick one, then run:

```powershell
flutter devices
flutter run -d <device-id>
```

To run on Windows desktop (if configured):

```powershell
flutter run -d windows
```

4. Running tests

This project contains a sample widget test at `test/widget_test.dart`.

```powershell
flutter test
```

## Project structure

- `lib/` - main app code
	- `main.dart` - app entry
	- `constants.dart` - app-wide constants
	- `screens/` - individual screens (`welcome_screen.dart`,
		`registration_screen.dart`, `login_screen.dart`, `chat_screen.dart`)
- `images/` - image assets used by the app
- `android/`, `ios/`, `web/`, `windows/`, `macos/`, `linux/` - platform folders

## How to extend

- Add a backend: Firebase Authentication + Firestore for real-time chat.
- Add persistent login state and message pagination for large chats.
- Improve accessibility and theming.

## Contributing

Contributions are welcome. Please open an issue first to discuss larger
changes. For small fixes or docs improvements, open a pull request with a
clear description of your changes.

## License

This project does not specify a license. Add a `LICENSE` file if you want to
make the project open source.

---

If you'd like, I can also:
- Add a brief README badge (build / Flutter SDK version).
- Add example screenshots into `images/` and reference them properly.
- Wire up Firebase in a branch and show a minimal working auth + chat flow.

