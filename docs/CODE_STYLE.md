### Freezed and Dart 3.13+ Primary Constructors

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

Freezed's generated mixin also declares these properties, causing the analyzer to report `annotate_overrides` because the primary-constructor fields implicitly override the declarations from `_$User`.

The `@override` annotation is not useful here because the fields are declared for the model itself; the generated mixin is an implementation detail of Freezed. Therefore, these classes use:

```dart
// ignore_for_file: annotate_overrides
```

as a file-level workaround rather than adding `@override` annotations to the fields.

This applies to Freezed classes using primary constructors, not to Freezed sealed-state declarations using `const factory` constructors.

#### Avoid

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

### Explicit Types with `context.read()`

Always specify the type when using `context.read()`, even when the type can already be inferred from the receiving parameter or surrounding context.

Prefer:

```dart
someMethod(context.read<HttpClient>());
```

over:

```dart
someMethod(context.read());
```

### Feature Directory Structure

Organize feature directories around the actual structure and responsibilities of each feature rather than forcing every feature into a universal directory template.

Feature directories should contain the code that belongs to that feature, including models, repositories, services, state management, UI, and other related classes where applicable. The internal directory structure should be determined case by case based on the actual relationships and responsibilities of the code.

Do not create directories solely for structural consistency when they do not provide meaningful grouping. For example, if a feature has only one repository and one service, keep those files directly in the feature directory rather than creating separate `repositories/` and `services/` directories containing one file each.

Likewise, do not create generic directories such as `cubits/` merely because a feature contains a single Cubit. A directory such as `login_cubit/` is appropriate when the Cubit forms a cohesive unit containing multiple related files, such as its state and event declarations.

Page and flow directories such as `home/` and `initial_setup/` should contain code specific to those pages or flows. They should not become containers for independent features that happen to be used by them. Features such as `settings/`, `user/`, or `auth/` remain independent so they can be reused by different pages and flows without creating dependencies on those higher-level compositions.

Consistency should be maintained where it reflects meaningful similarities between features, but structural consistency should not be pursued for its own sake.

### Follow [Unix philosophy](https://en.wikipedia.org/wiki/Unix_philosophy): "do one thing and do it well"

Keep classes, functions, packages, and other components focused on a clear responsibility. This concerns the responsibility of a component, not its size or number of lines.

Do not split code solely because a file or class is large, or create separate classes for individual functions when doing so does not establish a meaningful responsibility or boundary. Likewise, small components are valid when their focused responsibility naturally requires little code.

Modularity should be based on meaningful responsibilities and boundaries rather than arbitrary size limits or a fixed number of classes.
