# Code Style

## Freezed and Dart 3.13+ Primary Constructors

Dart 3.13 introduced [primary constructors](https://dart.dev/language/primary-constructors), allowing fields and the primary constructor to be declared directly in the class header, avoiding the field and constructor boilerplate of the traditional syntax.

For [Freezed](https://pub.dev/packages/freezed) classes that use a primary constructor, prefer this syntax:

```dart
@freezed
@immutable
class const User({
  required final int id,
  required final String name,
}) with _$User;
```

> [!TIP]
> `package:freezed` version must be at least [`4.0.1`](https://pub.dev/packages/freezed/changelog#401---2026-08-29) to remove the need for `@overrides` or `// ignore_for_file: annotate_overrides`.

This applies to Freezed classes using primary constructors, not to Freezed sealed-state declarations using `const factory` constructors.

See also: [Freezed primary constructors documentation](https://pub.dev/packages/freezed#primary-constructors)

### Avoid

Do not use the legacy Freezed syntax with a `const factory` constructor for regular model classes:

```dart
@freezed
@immutable
class User with _$User {
  const factory User({
    required int id,
    required String name,
  }) = _User;
}
```

## API Model Naming in [`package:librelab_api_contract`]

Use the `Response` suffix for models representing the response payload of a specific API operation when the base name would be ambiguous or overly generic.

Use the resource or domain object name without `Response` when the model represents a distinct API resource.

Prefer:

```dart
class LoginResponse();
class StorageObject();
```

Apply this convention consistently in this package. Do not add `Response` solely because a model is returned by an HTTP endpoint.

> [!TIP]
> In this package, the `Response` suffix refers to the API response payload, not the complete HTTP response containing status, headers, and other transport metadata.

[`package:librelab_api_contract`]: ../librelab_api_contract/
