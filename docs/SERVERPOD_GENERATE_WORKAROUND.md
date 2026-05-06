# Serverpod generate workaround

**Details:** https://github.com/serverpod/serverpod/issues/5002

**Solution:** Add the following to [librelab_client/lib/src/protocol/client.dart](../librelab_client/lib/src/protocol/client.dart) after running `serverpod generate`:

```dart
class EndpointEmailIdp extends _i1.EndpointEmailIdpBase {
  EndpointEmailIdp(_i2.EndpointCaller caller) : super(caller);

  // START: https://github.com/serverpod/serverpod/issues/5002
  @override
  Future<_i1.UuidValue> startRegistration({
    required String email,
  }) async {
    // Stub implementation to satisfy the Dart compiler.
    throw UnimplementedError();
  }
  // END
}
```

OR run this script instead: `dart ./scripts/serverpod_generate.dart`.