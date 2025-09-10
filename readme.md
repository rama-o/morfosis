# Rama

## Morfosis / FFMPEG converter
> batch video/audio convertion powered by ffmpeg
platform: f-droid and google play

## Tijera / FFMPEG editor
> small video editor that allows you to clip and convert a video or a song powered by ffmpeg
platform: f-droid, google play, linux mint

## Palomita / offline Audio/Video player
> the logo is a popcorm pigeon mix

## (no name) Downloader
> small app that allows you to download youtube videos into your device
platform: f-droid, google play, linux mint
------------------------------------------------------------

## Deps for builidng in Linux
```sh
sudo apt update && sudo apt install libsdl2-dev
```

## Build for Linux
```sh
g++ main.cpp -o hello_sdl `sdl2-config --cflags --libs` && ./hello_sdl
```

## Build for Android
```sh
cmake -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
      -DANDROID_ABI=arm64-v8a \
      -DANDROID_PLATFORM=android-24 \
      -S . -B build-android
cmake --build build-android
```