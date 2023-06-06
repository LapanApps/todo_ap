# Todo App (UKM)

A simple TODO app with Firebase Firestore as database & backend.

https://github.com/LapanApps/todo_ap/assets/60868965/c4e17104-a0fb-4dd9-9411-86d55e3286bc

## Features

- Data synced to Firebase Firestore
- Simple input validation: The data will not be updated if user give an empty value
- Switch to change theme

## Getting Started

1. Clone this project by running `git clone https://github.com/LapanApps/todo_ap.git`
1. Open project in vscode
1. Run `flutter pub get` to install dependencies
1. To use your own Firebase project, run `flutterfire configure`. Learn more on: https://firebase.google.com/docs/flutter/setup
1. Run the app. You can use `flutter run` or `F5` in vscode

## Deploying

https://todo-flutter-ukm.web.app/#/

You can deploy the Flutter web app to Firebase Hosting. Steps:

- Within the Flutter project, run `flutter build web` to build the web app
- Run `firebase init`. Make sure you already install the Firebase CLI: https://firebase.google.com/docs/cli
- `Are you ready to proceed? (Y/n)` - `Y`
- `Which Firebase CLI features do you want to set up for this folder? Press Space to select features, then Enter to confirm your choices.` - Select `Hosting: Configure and deploy Firebase Hosting sites` - Enter
- Select your Firebase project
- `What do you want to use as your public directory? (public)` - `build/web`
- `Configure as a single-page app (rewrite all urls to /index.html)? (y/N)` - `N`
- `Set up automatic builds and deploys with GitHub? (y/N)` - `N`
- Run `firebase deploy`
