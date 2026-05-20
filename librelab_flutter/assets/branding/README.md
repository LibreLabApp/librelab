# Icons

### Generating the icon as PNG

LibreLab icon files are generated from a Flutter widget:

```bash
flutter run --target=lib/icon_main.dart
```

Once saved, copy-paste the framed and unframed icon files to this directory.

### Generating the platform runner icons

Assuming `flutter_launcher_icons` is configured in `pubspec.yaml`
to use the files generated from the previous step,
the [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) CLI
can be used to update the platform runner icons (e.g., `/android`, `macos`):

```bash
dart run flutter_launcher_icons
```

This will replace the icon files for all platforms except Linux desktop.

#### Linux

The icon is handled separately depending on the packaging solution.

For example, the Flatpak manifest of this app clones this repository and copies
[`icon.svg`](icon.svg) and [`.desktop`](../../packaging/linux/app.librelab.librelab.desktop) file (see also: [Convert to SVG](#convert-to-svg)).

### Icon files are not bundled as Flutter assets

The files in this directory are **not** bundled as Flutter assets:

```yaml
flutter:
  assets:
    # UNNECESSARY: These files exist to generate platform runner icons via a CLI tool.
    - assets/branding/ # Avoid
```

Instead, use the Flutter app widget (`LibreLabIcon`).

```dart
Scaffold(body: LibreLabIcon())
```

### Convert to SVG

Assuming that `icon.png` exists
(generated from [this step](#generating-the-icon-as-png)).

Avoid using proprietary software if possible:

1. Install [Inkscape](https://inkscape.org/)
2. Open [`icon.png`](./icon.png) in Inkscape (with default import settings)
3. Go to Path -> Trace bitmap
4. Choose **Multicolor**
5. Set:
  - Detection Mode: Colors
  - Scans: 5
  - Enable: Stack scans
6. Update preview and then apply
7. Move the new vector off the original PNG, delete the original PNG
8. Select the icon, File -> Save As
9. Change "Guess from extension" to "Plain SVG"
10. Change the file extension and save
11. Open the saved SVG file and remove the white background:

```patch
- <path
- style="fill:#fefefe"
- d="M 0,512 V 0 h 512 512 v 512 512 H 512 0 Z"
- id="path37" />
```
