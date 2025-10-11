[![Morfosis](https://rama-o.github.io/img/preview-morfosis.webp)](https://morfosis-o.github.io)

# 🌀 Morfosis

**Morfosis** is a **privacy-first media conversion app** that is simple, fast, and fully offline.

Powered by **FFmpeg**, Morfosis lets you convert **audio and video files** between many formats, all processed locally on your device without any internet connection.

<p align="center">
<a href="https://github.com/rama-o/morfosis/releases" alt="GitHub NewPipe releases"><img src="https://img.shields.io/github/release/rama-o/morfosis.svg" ></a>
<a href="https://www.gnu.org/licenses/gpl-3.0" alt="License: GPLv3"><img src="https://img.shields.io/badge/License-GPL%20v3-blue.svg"></a>
<a href="https://github.com/rama-o/morfosis/actions" alt="Build Status"><img src="https://github.com/rama-o/morfosis/actions/workflows/ci.yml/badge.svg?branch=dev&event=push"></a>
</p>

---

## 🚀 Run the App

```bash
flutter run
```

or to restart and run:

```bash
flutter clean && flutter pub get && flutter run
```

---

## 🔐 Permissions

Morfosis needs the following permissions:

* **Device Storage / Gallery** – to pick and access your media files
* **Notifications** – to show when batch conversions start and finish

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

### 3. Test the Release Build

```bash
adb uninstall com.rama.morfosis && flutter run --release -v
```

---

## 🧾 License

[![GNU GPLv3 Image](https://www.gnu.org/graphics/gplv3-127x51.png)](https://www.gnu.org/licenses/gpl-3.0.en.html)

**Morfosis** is Free Software. You can use, study, share, and improve it freely.
It is distributed under the [GNU General Public License](https://www.gnu.org/licenses/gpl.html), version 3 or (at your option) any later version.