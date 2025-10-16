# cinema_app_03

A new Flutter project.

# Development

## Environment variables

Copy the file `.env.template` to `.env` and add the environment variables.

## Run the app

Run the app with `flutter run`.

## Build the app

Build the app with `flutter build apk`.

## Deploy the app

Deploy the app to the Google Play Store.

## Change app package name

Run `dart run change_app_package_name:main com.gustavocaqui.cinema_app_03`.

Change the app package name in the `android/app/src/main/AndroidManifest.xml` file.

Change the app package name in the `android/app/build.gradle` file.

## Change app icon

Run `dart run flutter_launcher_icons:main`.

Change the app icon in the `android/app/src/main/res` directory.

## Change app splash screen

Run `dart run flutter_native_splash:create`.

Run `dart run flutter_native_splash:create --path=path/to/my/file.yaml`.

Change the app splash screen in the `android/app/src/main/res` directory.

## Change app keystore

Run `flutter build appbundle --release`.

Run `flutter build appbundle --release --target=lib/main.dart`.

Run `flutter build appbundle --release --target=lib/main.dart --split-debug-info=build/app/outputs/bundle/release/`.

Run `flutter build appbundle --release --target=lib/main.dart --split-debug-info=build/app/outputs/bundle/release/ --no-tree-shake-icons`.

Run `flutter build appbundle --release --target=lib/main.dart --split-debug-info=build/app/outputs/bundle/release/ --no-tree-shake-icons --no-tree-shake-icons`.

## Change app version

Change the app version in the `android/app/build.gradle` file.

Change the app version in the `android/app/src/main/AndroidManifest.xml` file.

Change the app version in the `pubspec.yaml` file.

Change the app version in the `README.md` file.

## Change app name

Change the app name in the `android/app/src/main/AndroidManifest.xml` file.
