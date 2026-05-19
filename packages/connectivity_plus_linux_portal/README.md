A Linux implementation of [connectivity_plus](https://pub.dev/packages/connectivity_plus) that uses XDG Desktop Portal for sandbox compliance (e.g., Flathub/Flatpak). Address [upstream issue](https://github.com/fluttercommunity/plus_plugins/issues/1241).

### Getting Started

```dart
import 'package:connectivity_plus_linux_portal/connectivity_plus_linux_portal.dart';

void main() {
  if (Platform.isLinux) {
    _maybeUseNetworkMonitorPortal();
  }
}

void _maybeUseNetworkMonitorPortal() {
  final isFlatpak =
      Platform.environment.containsKey('FLATPAK_ID') ||
      Platform.environment['container'] == 'flatpak';
  final backend = Platform.environment['CONNECTIVITY_BACKEND'];
  final usePortal = isFlatpak || backend == 'portal';

  if (usePortal) {
    ConnectivityPlusLinuxPortalPlugin.registerWith();
  }
}
```

Then pass the environment variable in the Flatpak manifest (optional fallback in case `FLATPAK_ID` env variable was not found):

```yaml
finish-args:
  - "--env=CONNECTIVITY_BACKEND=portal"
```

### Motivation

The [default `connectivity_plus` Linux implementation uses `nm`](https://github.com/fluttercommunity/plus_plugins/blob/main/packages/connectivity_plus/connectivity_plus/lib/src/connectivity_plus_linux.dart#L5),
which uses `org.freedesktop.NetworkManager`, which causes:

```console
ERROR:flutter/runtime/dart_vm_initializer.cc(40)] Unhandled Exception: org.freedesktop.DBus.Error.ServiceUnknown: org.freedesktop.DBus.Error.ServiceUnknown
#0      DBusClient._callMethod (package:dbus/src/dbus_client.dart:1124)
```

While you you can add (last resort):

```yaml
finish-args:
  - --talk-name=org.freedesktop.NetworkManager
```

This approach is typically **discouraged** when submitting an app to Flathub ([example comment](https://github.com/flathub/flathub/pull/8362#discussion_r3097282313)).

This package uses [xdg_desktop_portal](https://pub.dev/packages/xdg_desktop_portal). Both `xdg_desktop_portal` and `nm` uses [dbus](https://pub.dev/packages/dbus) package.

### Limitations

This package uses `org.freedesktop.portal.NetworkMonitor`, which supports fewer `ConnectivityResult` types (by design for sandbox/privacy reasons).

Usually, it reports either `other` or `none`:

```dart
ConnectivityResult _map(XdgNetworkStatus status) {
  final connectivity = status.connectivity;
  if (!status.available || connectivity == .local) {
    return ConnectivityResult.none;
  }

  switch (connectivity) {
    case XdgNetworkConnectivity.local:
      return .none;

    case XdgNetworkConnectivity.portal:
      return .wifi;
    case XdgNetworkConnectivity.limited:
    case XdgNetworkConnectivity.full:
      if (status.metered) {
        return ConnectivityResult.mobile;
      }
      return ConnectivityResult.other;
  }
}
```

You can use the portal implementation only for the Flatpak version (e.g., via environment variable or argument) and keep the default implementation (as shown in [this section](#getting-started)).

> [!NOTE]
> [Credit @sgehrman](https://github.com/fluttercommunity/plus_plugins/issues/1241#issuecomment-1483770198) for sharing the approach.
