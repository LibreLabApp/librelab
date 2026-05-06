import 'package:librelab_client/librelab_client.dart';

final class ClientCache {
  final Map<String, Client> _cache = {};

  Client getClient(String serverUrl) {
    final uri = Uri.tryParse(serverUrl);
    if (uri == null || !(uri.isScheme('http') || uri.isScheme('https'))) {
      throw ArgumentError.value(
        serverUrl,
        'serverUrl',
        'must start with http:// or https://',
      );
    }
    return _cache.putIfAbsent(serverUrl, () => Client(serverUrl));
  }
}
