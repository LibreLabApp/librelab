part of 'generator.dart';

@immutable
class Config {
  const Config({
    required this.input,
    required this.dartOutput,
    required this.outputClassName,
    required this.requiredTypesImport,
  });

  final ApiGroup input;

  final String dartOutput;
  final String outputClassName;

  /// The import that provides [HttpEndpoint], [WebSocketEndpoint] and [HttpMethod]
  final String requiredTypesImport;
}
