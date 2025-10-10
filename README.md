# 🌀 Morfosis

**Morfosis** is a **privacy-first media conversion app** designed to be simple, fast, and accessible.

Powered by **FFmpeg**, Morfosis lets you convert **audio and video files** between a wide range of formats — all locally, with no internet connection required.

---

## 🚀 Run or Reset the App

```bash
flutter clean
flutter pub get
flutter run
```

---

## 🔐 Permissions

Morfosis requires the following permissions:

- **Storage** – to read and save converted media files
- **Notifications** – to alert you when batch processing starts and completes

---

## 🏗️ Build Instructions

### 1. Generate a Signing Key

```bash
keytool -genkeypair -v \
  -keystore ~/morfosis.jks \
  -alias morfosis \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000
```

### 2. Build the Release APK

```bash
flutter build apk --release
```

### 3. Test release

```bash
adb uninstall com.rama.morfosis && flutter run --release -v
```

---

## 💡 Notes

- The app uses **FFmpeg** for high-performance, offline media conversion.
- All processing happens **locally on your device** — no data ever leaves it.
- You can reset the app’s state (including permissions) by clearing app data or running:

  ```bash
  adb shell pm clear com.rama.morfosis
  ```
