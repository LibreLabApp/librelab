// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:api_client/api_client.dart';
import 'package:http/http.dart';
import 'package:librelab_api_client/librelab_api_client.dart';
import 'package:logging/logging.dart';

void main() async {
  final httpClient = Client();

  final client = LibreLabApiClient(
    apiClient: HttpApiClientDart(httpClient),
    logger: Logger('LibreLabApiClient'),
    onAuthSessionRefreshed: (_) async {},
  );

  final serverBaseUrl = Uri.http('localhost:45123', '/api');

  final response = await client.endpoints.auth.login(
    const .new(email: 'test@example.org', password: '123', deviceId: null),
    serverBaseUrl: serverBaseUrl,
  );

  switch (response) {
    case HttpStatusSuccess(:final response):
      print('User ID: ${response.body.user.id}');
    case HttpStatusError(:final response):
      print('Error: ${response.body.message}');
  }

  httpClient.close();
}
