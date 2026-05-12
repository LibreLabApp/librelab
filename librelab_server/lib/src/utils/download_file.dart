import 'dart:io';

final class DownloadFileException implements Exception {
  const DownloadFileException({required this.statusCode, required this.url});

  final int statusCode;
  final Uri url;

  @override
  String toString() {
    return 'Failed to download file "$url": $statusCode';
  }
}

/// Downloads file from [url] into [file].
///
/// Throws [DownloadFileException] if HTTP status code is not `200`.
///
/// Calls (consumers should handle [Exception]):
/// - [HttpClient.getUrl]: may throw [SocketException].
/// - [File.openWrite] may throw [FileSystemException] or [IOException].
///
/// **Note:** This creates a new [HttpClient] for each file download,
/// which is typically inefficient. However, at the time of writing this
/// comment: the server downloads only two files on initial launch (worst-case scenario).
///
/// These files are PostgreSQL and Bonjour installer files on Windows,
/// so this technical debt is acceptable.
Future<void> downloadFile(Uri url, File file) async {
  HttpClient? client;
  IOSink? sink;

  try {
    client = HttpClient();

    // During development only: allow bypassing bad certificates validation
    // for Windows 11 guest OS in VM testing
    // ignore: prefer_asserts_with_message
    assert(() {
      final allowBadCertificates =
          Platform.environment['ALLOW_BAD_CERTIFICATES']
              ?.trim()
              .toLowerCase() ==
          'true';
      if (allowBadCertificates) {
        client!.badCertificateCallback = (_, host, _) {
          stderr.writeln(
            'Security warning: Ignoring bad certificate for $host',
          );
          return true;
        };
      }

      return true;
    }());

    final request = await client.getUrl(url);
    final response = await request.close();

    if (response.statusCode != 200) {
      try {
        await response.drain<void>();
      } on Exception {
        // No-op
      }

      throw DownloadFileException(statusCode: response.statusCode, url: url);
    }

    sink = file.openWrite();
    await response.pipe(sink);
  } finally {
    await sink?.close();
    client?.close();
  }
}
