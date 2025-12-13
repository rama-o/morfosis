![Morfosis](https://raw.githubusercontent.com/jmiguelrivas/morfosis/refs/heads/main/fastlane/metadata/android/en-US/images/featureGraphic.png)

# 🌀 Morfosis

**Morfosis** is a **privacy-first media conversion app** that is simple, fast, and fully offline.

Powered by **FFmpeg**, Morfosis lets you convert **audio and video files** between many formats, all processed locally on your device without any internet connection.

![Morfosis Preview](https://raw.githubusercontent.com/jmiguelrivas/morfosis/main/morfosis-preview-min.webp)

<p align="center">
<a href="https://github.com/jmiguelrivas/morfosis/releases"><img alt="GitHub Morfosis releases" src="https://img.shields.io/github/release/jmiguelrivas/morfosis.svg" ></a>
<a href="https://www.gnu.org/licenses/gpl-3.0"><img alt="License: GPLv3" src="https://img.shields.io/badge/License-GPL%20v3-blue.svg"></a>
<a href="https://github.com/jmiguelrivas/morfosis/actions"><img alt="Build Status" src="https://github.com/jmiguelrivas/morfosis/actions/workflows/test.yml/badge.svg?branch=main&event=push"></a>
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

### 1. Remove IMGs metadata

```bash
find . -name '*.jpg' -o -name '*.jpeg' -o -name '*.png' | xargs exiftool -all= -overwrite_original

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
