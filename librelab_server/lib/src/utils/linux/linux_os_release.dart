import 'dart:io';

class LinuxOsRelease {
  static const String filePath = '/etc/os-release';
  List<String>? _osReleaseLines;

  Future<List<String>> _readFile() async {
    final osReleaseFile = File(filePath);
    return _osReleaseLines = await osReleaseFile.readAsLines();
  }

  Future<String?> readValue(String key) async {
    final osReleaseLines = _osReleaseLines ?? await _readFile();

    for (final line in osReleaseLines) {
      if (!line.startsWith(key)) {
        continue;
      }

      final value = line.replaceFirst('$key=', '');
      final normalizedValue = value.startsWith('"') && value.endsWith('"')
          ? value.substring(1, line.length - 1)
          : value;

      return normalizedValue;
    }

    return null;
  }
}

extension LinuxOsReleaseX on LinuxOsRelease {
  Future<String?> detectAptBaseCodename() async {
    // Linux Mint exposes Ubuntu base codename in UBUNTU_CODENAME
    final ubuntuCodename = await readValue('UBUNTU_CODENAME');
    if (ubuntuCodename != null && ubuntuCodename.isNotEmpty) {
      return ubuntuCodename;
    }

    // Debian/Ubuntu fallback.
    final versionCodename = await readValue('VERSION_CODENAME');
    if (versionCodename != null && versionCodename.isNotEmpty) {
      return versionCodename;
    }

    return versionCodename;
  }
}
