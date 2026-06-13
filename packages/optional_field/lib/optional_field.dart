import 'package:meta/meta.dart';

@immutable
sealed class Field<T> {
  const Field();

  const factory Field.value(T value) = Present<T>;
  const factory Field.absent() = Absent<T>;

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

final class Absent<T> extends Field<T> {
  const Absent();
}

final class Present<T> extends Field<T> {
  const Present(this.value);

  @override
  final T value;
}
