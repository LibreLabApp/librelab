import 'package:meta/meta.dart';

@immutable
sealed class const Field<T>() {
  const factory value(T value) = Present<T>;
  const factory absent() = Absent<T>;

  /// Assumes `null` means [Absent] and a non-null value means [Present].
  factory Field.fromNullable(T? value) {
    if (value != null) {
      return .value(value);
    }
    return const .absent();
  }

  bool get isPresent => switch (this) {
    Absent<T>() => false,
    Present<T>() => true,
  };

  T? get value => switch (this) {
    Absent<T>() => null,
    // IMPORTANT: Removing ":final value" silently introduces a bug
    Present<T>(:final value) => value,
  };

  T get valueOrThrow {
    return switch (this) {
      Absent<T>() => throw StateError('value is absent'),
      Present<T>(:final value) => value,
    };
  }
}

final class const Absent<T>() extends Field<T>;

final class const Present<T>(@override final T value) extends Field<T>;
