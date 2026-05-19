import 'dart:async';

import 'package:connectivity_plus_platform_interface/connectivity_plus_platform_interface.dart';
import 'package:xdg_desktop_portal/xdg_desktop_portal.dart';

typedef XdgDesktopPortalClientFactory = XdgDesktopPortalClient Function();

class ConnectivityPlusLinuxPortalPlugin extends ConnectivityPlatform {
  ConnectivityPlusLinuxPortalPlugin({this._factory});

  final XdgDesktopPortalClientFactory? _factory;

  XdgDesktopPortalClient _createPortal() {
    return _factory?.call() ?? XdgDesktopPortalClient();
  }

  static void registerWith() {
    ConnectivityPlatform.instance = ConnectivityPlusLinuxPortalPlugin();
  }

  @override
  Future<List<ConnectivityResult>> checkConnectivity() async {
    final portal = _createPortal();

    try {
      final status = await portal.networkMonitor.status.first;

      return [_map(status)];
    } finally {
      await portal.close();
    }
  }

  StreamController<List<ConnectivityResult>>? _controller;
  XdgDesktopPortalClient? _portal;
  StreamSubscription<XdgNetworkStatus>? _sub;

  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged {
    _controller ??= StreamController.broadcast(
      onListen: _startListenConnectivity,
      onCancel: _stopListenConnectivity,
    );
    return _controller!.stream;
  }

  XdgDesktopPortalClient _maybeCreatePortal() {
    return _portal ??= _createPortal();
  }

  void _startListenConnectivity() {
    final portal = _maybeCreatePortal();
    _sub = portal.networkMonitor.status.listen((status) {
      _controller!.add([_map(status)]);
    });
  }

  Future<void> _stopListenConnectivity() async {
    await _sub?.cancel();
    _sub = null;

    await _portal?.close();
    _portal = null;
  }

  ConnectivityResult _map(XdgNetworkStatus status) {
    final connectivity = status.connectivity;
    if (!status.available || connectivity == .local) {
      return .none;
    }

    switch (connectivity) {
      case .local:
        return .none;

      case .portal:
        return .wifi;
      case .limited:
      case .full:
        if (status.metered) {
          return .mobile;
        }
        return .other;
    }
  }
}
