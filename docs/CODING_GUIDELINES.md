# Coding Guidelines

## Fail Fast on Invalid API Usage

Validate inputs at API boundaries when an invalid value represents incorrect usage of the API. Throw an appropriate [`Error`] immediately rather than allowing the invalid value to propagate and fail later in a less clear or harder-to-debug location.

Use runtime validation for conditions that must remain enforced in production. Do not rely on `assert` for these checks.

For example:

```dart
/// Sets the maximum number of retries.
///
/// [retries] must be non-negative.
void setMaxRetries(int retries) {
  if (retries < 0) {
    throw ArgumentError.value(retries, 'retries', 'must be non-negative');
  }

  // ...
}

void setPort(int port) {
  if (port < 1 || port > 65535) {
    throw ArgumentError.value(port, 'port', 'must be between 1 and 65535');
  }

  // ...
}
```

> [!TIP]
> For invalid API usage that indicates a programming error in Dart, throw an [`Error`] such as `ArgumentError` rather than an [`Exception`] such as `FormatException`.

## Do Not Catch [`Error`] in Dart

In Dart, [`Error`] represents a programming error that should be prevented or fixed rather than handled at runtime. Do not catch `Error` or its subclasses in normal application code.

Catch [`Exception`] when an exceptional runtime condition is expected and can be handled. Do not catch `Error` to recover from programming bugs or hide them.

> [!TIP]
> This project enables the [`avoid_catching_errors`](https://dart.dev/tools/linter-rules/avoid_catching_errors) lint rule to enforce this convention.

## Explicit Types with `context.read()`

Always specify the type when using `context.read()`, even when the type can already be inferred from the receiving parameter or surrounding context.

Prefer:

```dart
someMethod(context.read<HttpClient>());
```

over:

```dart
someMethod(context.read());
```

## Follow [Unix philosophy]: "do one thing and do it well"

Keep classes, functions, packages, and other components focused on a clear responsibility. This concerns the responsibility of a component, not its size or number of lines.

Do not split code solely because a file or class is large, or create separate classes for individual functions when doing so does not establish a meaningful responsibility or boundary. Likewise, small components are valid when their focused responsibility naturally requires little code.

Modularity should be based on meaningful responsibilities and boundaries rather than arbitrary size limits or a fixed number of classes.

## Feature Directory Structure

Organize feature directories around the actual structure and responsibilities of each feature rather than forcing every feature into a universal directory template.

Feature directories should contain the code that belongs to that feature, including models, repositories, services, state management, UI, and other related classes where applicable. The internal directory structure should be determined case by case based on the actual relationships and responsibilities of the code.

Do not create directories solely for structural consistency when they do not provide meaningful grouping. For example, if a feature has only one repository and one service, keep those files directly in the feature directory rather than creating separate `repositories/` and `services/` directories containing one file each.

Likewise, do not create generic directories such as `cubits/` merely because a feature contains a single Cubit. A directory such as `login_cubit/` is appropriate when the Cubit forms a cohesive unit containing multiple related files, such as its state and event declarations.

Page and flow directories such as `home/` and `initial_setup/` should contain code specific to those pages or flows. They should not become containers for independent features that happen to be used by them. Features such as `settings/`, `user/`, or `auth/` remain independent so they can be reused by different pages and flows without creating dependencies on those higher-level compositions.

Consistency should be maintained where it reflects meaningful similarities between features, but structural consistency should not be pursued for its own sake. Do not apply architectural patterns by template. Introduce a component, layer, or directory when the feature's actual responsibilities and relationships justify it.

## Separate Request-Level and Endpoint-Specific Failures

Keep failures that are common to API requests separate from outcomes specific to an individual API operation.

The [`package:librelab_api_client`] exposes successful response payloads and structured server error responses without mapping endpoint-specific error codes to application failures. `ApiRequestFailure` represents request-level failures that can be handled consistently across API requests, such as connection failures, invalid responses, authorization failures, and unhandled server errors.

Endpoint-specific outcomes should be modeled separately by the corresponding repository or feature. For example, authentication-specific server error codes should be mapped to `LoginFailure` rather than added to `ApiRequestFailure`.

This separation allows common request failures to be handled consistently while keeping endpoint-specific outcomes explicit and type-safe.

## Forward-Compatible API Enums

Enums shared between the server and client should generally include an `unknown` value when they are returned in API responses. This allows older clients to continue deserializing responses when a new enum value is added by the server.

For example:

```dart
@JsonSerializable()
class StorageObject({
  @JsonKey(
    // Adding a new enum is not considered a breaking change.
    unknownEnumValue: StorageObjectPurpose.unknown,
  )
  required final StorageObjectPurpose purpose,
}) {
  // ...
}

enum StorageObjectPurpose {
  labImage,

  /// The server sent an enum that this client does not recognize.
  unknown,
}
```

Use `unknown` as a fallback for unrecognized values. Do not treat it as a valid value when an operation requires a known enum value.

> [!NOTE]
> Using a distinct `unknown` value preserves the difference between a value that is present but not recognized by the client and an absent value.
> Mapping an unrecognized enum value to `null` would make these two states indistinguishable.

## API Response Status Codes

Prefer `200 OK` with an empty JSON object (`{}`) for endpoints that currently have no response data but may return data in the future.

Use `204 No Content` for endpoints that are not expected to ever return a response body.

## Keep the API Contract Limited to Shared Contracts

The [`package:librelab_api_contract`] defines the parts of the API that form an explicit contract shared between the server and its clients. It is not a complete representation of everything exposed or returned by the server.

Only define something in the API contract package when both sides need to share its definition or semantics. Server implementation details, client-specific behavior, and values that are not relied upon by both sides can remain in their respective packages.

This applies to models, error codes, HTTP status codes, enums, constants, and other API-related definitions. A value being returned by the server does not by itself make it part of the contract. It becomes part of the shared contract when clients need to understand, parse, or depend on it explicitly.

Keep the contract focused on meaningful shared boundaries rather than mirroring the entire server API surface.

> [!TIP]
> Changes outside the API contract are not considered contract-breaking changes, even though clients may still depend on undocumented server behavior accidentally. Such dependencies should be treated as client or server bugs rather than additions to the API contract.

## Separate API Contract, Server, and Client Application Models

Keep API contract models, server models, and client application models separate, even when they currently have identical fields.

API contract models represent the wire format and compatibility requirements. Server models represent server-side domain state and behavior. Client application models represent application state and behavior.

Do not reuse models across these layers merely because their current representations are identical. Each layer should evolve independently.

For example, an API enum may contain `unknown` for backward-compatible deserialization of values introduced by newer servers (see also: [Forward-Compatible API Enums](#forward-compatible-api-enums)), while the server enum contains only supported values. The client application model may also contain `unknown` to represent unrecognized values in the UI. Likewise, server models may implement server-specific interfaces such as `Auditable`.

Map between these representations at layer boundaries.

[`Error`]: https://api.flutter.dev/flutter/dart-core/Error-class.html

[`Exception`]: https://api.flutter.dev/flutter/dart-core/Exception-class.html

[Unix philosophy]: https://en.wikipedia.org/wiki/Unix_philosophy

[`package:librelab_api_client`]: ../librelab_api_client/
[`package:librelab_api_contract`]: ../librelab_api_contract/
