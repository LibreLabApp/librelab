part of 'generator.dart';

@immutable
class const Config({
  required final ApiGroup input,

  required final String dartOutput,
  required final String outputClassName,

  /// The import that provides [HttpEndpoint], [WebSocketEndpoint], and [HttpMethod].
  ///
  /// These types exist in the code generator.
  /// However they are different in the final generated code.
  required final String requiredTypesImport,
});
