import 'dart:async';

typedef ShutdownHook = FutureOr<void> Function();

class ShutdownHookRegistry {
  final Map<String, ShutdownHook> _hooks = {};

  void register(String id, ShutdownHook hook) {
    _hooks[id] = hook;
  }

  void clear() {
    _hooks.clear();
  }

  Map<String, ShutdownHook> get hooks => Map.unmodifiable(_hooks);
}
