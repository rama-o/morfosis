# Morfosis

Morfosis is a privacy-first media conversion app designed to be simple and accessible.

Powered by FFmpeg, Morfosis allows you to convert audio and video files between a wide range of formats.

sign key
'''
keytool -genkey -v -keystore ~/morfosis.jks -alias morfosis -keyalg RSA -keysize 2048 -validity 10000
'''

build:
```sh
flutter build apk --release
```