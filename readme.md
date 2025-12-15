![Morfosis](https://raw.githubusercontent.com/jmiguelrivas/morfosis/refs/heads/main/fastlane/metadata/android/en-US/images/featureGraphic.png)

# Morfosis

**Morfosis** is a **privacy-first media conversion app** that is simple, fast, and fully offline.

Powered by **FFmpeg**, Morfosis lets you convert **audio and video files** between many formats, all processed locally on your device without any internet connection.

<p align="center">
<a href="https://github.com/jmiguelrivas/morfosis/releases"><img alt="GitHub Morfosis releases" src="https://img.shields.io/github/release/jmiguelrivas/morfosis.svg"></a>
<a href="https://www.gnu.org/licenses/gpl-3.0"><img alt="License: GPLv3" src="https://img.shields.io/badge/License-GPL%20v3-blue.svg"></a>
<a href="https://github.com/jmiguelrivas/morfosis/actions"><img alt="Build Status" src="https://github.com/jmiguelrivas/morfosis/actions/workflows/test.yml/badge.svg?branch=main&event=push"></a>
</p>

---

## 🔐 Permissions

Morfosis needs the following permissions:

* **Device Storage / Gallery** – to pick and access your media files
* **Notifications** – to show when batch conversions start and finish

---

## 🎥 Supported Video Formats & Codecs

| Format | Description                                  | Codecs                          |
| ------ | -------------------------------------------- | ------------------------------- |
| mp4    | Most compatible video format                 | libx264, libx265 |
| avi    | Legacy format, widely supported              | libx264          |
| mov    | Apple QuickTime format                       | libx264, libx265 |
| webm   | Web-friendly format                          | libx264          |
| mkv    | Advanced container, supports multiple codecs | libx264, libx265 |
| flv    | Streaming format                             | libx264          |
| 3gp    | Mobile-friendly, legacy phones               | mpeg4, h263      |
| 3g2    | 3GPP2 format, CDMA networks                  | mpeg4, h263      |

---

## 🎵 Supported Audio Formats & Codecs

| Format | Description                     | Codecs                                        |
| ------ | ------------------------------- | --------------------------------------------- |
| mp3    | Most compatible audio format    | libmp3lame                     |
| m4a    | Apple-friendly audio format     | aac                            |
| wav    | Uncompressed audio              | pcm_s16le                      |
| flac   | Lossless audio format           | flac                           |
| ogg    | Open source audio format        | aac                            |
| mp4    | Most compatible video container | aac, libmp3lame, ac3           |
| avi    | Legacy video container          | libmp3lame, ac3, pcm_s16le     |
| mov    | Apple QuickTime video container | aac, libmp3lame, pcm_s16le     |
| webm   | Web-friendly container          | aac                            |
| mkv    | Advanced container              | aac, ac3, libmp3lame, flac     |
| flv    | Streaming container             | aac, libmp3lame                |
| 3gp    | Mobile legacy container         | aac, libopencore_amrnb, amr_wb |
| 3g2    | CDMA legacy container           | aac, libopencore_amrnb, amr_wb |

---

## 📦 Installation from source

See the [Installation guide](installation.md) for setup instructions.

---

## 🧾 License

[![GNU GPLv3 Image](https://www.gnu.org/graphics/gplv3-127x51.png)](https://www.gnu.org/licenses/gpl-3.0.en.html)

**Morfosis** is Free Software. You can use, study, share, and improve it freely.
It is distributed under the [GNU General Public License](https://www.gnu.org/licenses/gpl.html), version 3 or (at your option) any later version.