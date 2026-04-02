# Walletly - GetX Static Wallet App

A Flutter wallet app with complete static UI flows using GetX routing/state management.

## Tech Stack

- Flutter
- GetX (`get: ^4.6.6`)

## Implemented Screens

- Onboarding
- Login
- Register
- Forgot Password
- Wallet Shell (Bottom Navigation)
  - Home
  - Cards
  - Activity
  - Profile
- Send Money
- Request Money
- Analytics
- Notifications
- Settings

## Project Structure

```text
lib/
  app/
    app.dart
    data/
    modules/
      auth/
      onboarding/
      wallet/
    routes/
    theme/
    widgets/
```

## Run Locally

```bash
flutter pub get
flutter run
```

## Quality Checks

```bash
flutter analyze
flutter test
```
