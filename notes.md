todo

- add tests
- confirmation message for deleting and clearing the queue

- work in the branding
- github organization
- video demo

- home page
- design page
- license page

-----------------------------------------------------------

- message for begin processing
- use android notifications instead
- change progress bar for waiting and check icon to indicate the state of the process
- add overwrite check
- converting files in order
- show omitted error
- add spinner animation (an oscialting line) for when the file is beign process
- add spinner static (a straiht line) for when the file havent started
- connect ffmpeg with dart
- add menu in the corner to access multiple sections
- add about morfosis section
- split main.dart
- empty list message with add files cta
- prevent duplication
- clear list
- delete file from the list
- open file manager and get actual file names
- create themes from the accento color




dart run flutter_launcher_icons && flutter run








# Rama

## Morfosis / FFMPEG converter
> batch video/audio convertion powered by ffmpeg
platform: f-droid and google play

- strip metadata

```sh
ffmpeg -i in.mov -map_metadata -1 -c copy out.mov
```

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

----------------------------------------------------------

to run the app
```
flutter run
```


# morfosis

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
