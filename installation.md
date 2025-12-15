![Morfosis](https://raw.githubusercontent.com/jmiguelrivas/morfosis/refs/heads/main/fastlane/metadata/android/en-US/images/featureGraphic.png)

# Installation

## 🚀 Run the App

```bash
flutter run
````

or to restart and run:

```bash
flutter clean && flutter pub get && flutter run
```

---

## 🏗️ Build Instructions

### Build the Release APK

```bash
flutter build apk --release
```

### Build the Release APK for individual architectures

```bash
flutter build apk --split-per-abi
```

### Test the Release Build

```bash
adb uninstall com.rama.morfosis && flutter run --release -v
```
