import 'dart:async';

import 'package:flutter/widgets.dart';

/// A [Listenable] that notifies listeners whenever any of the provided
/// streams emit an event.
///
/// Serves as a replacement for `GoRouterRefreshStream`, which was removed
/// in `go_router` 5.0.
/// https://flutter.dev/go/go-router-v5-breaking-changes
class GoRouterRefreshStream(Iterable<Stream<dynamic>> streams)
    extends ChangeNotifier {
  this {
    notifyListeners();

    _subscriptions = [
      for (final stream in streams)
        stream.asBroadcastStream().listen((_) => notifyListeners()),
    ];
  }

  late final List<StreamSubscription<dynamic>> _subscriptions;

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }
}
