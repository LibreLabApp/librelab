import 'dart:io' show File, Process, exit, stderr, stdout;

import 'package:yaml/yaml.dart';

import '_utils.dart';
import 'packages.dart';

const _targets = <String>[Packages.flutter, Packages.server];

const _generatedPubspecDestination = 'lib/generated/pubspec.g.dart';

void main() async {
  for (final target in _targets) {
    final pubspecYamlFile = File('$target/pubspec.yaml');
    final pubspecYamlText = await pubspecYamlFile.readAsString();
    final pubspecYaml = loadYaml(pubspecYamlText) as YamlMap;

    final fullVersion = pubspecYaml['version'].toString();
    if (!fullVersion.contains('+')) {
      stderr.writeln(
        'The version should contains the build number too (e.g., 1.0.0+1): $fullVersion',
      );
      exit(1);
    }

    final parts = fullVersion.split('+');
    final version = parts[0];
    final versionBuildNumber = parts[1];
    final topics = (pubspecYaml['topics'] as YamlList?)?.map((e) => "'$e'");

    final generatedDartFile =
        '''
// dart format off
// coverage:ignore-file

// GENERATED FILE - Don't modify by hand.
// Update pubspec.yaml and run the following script:
// dart $scriptRelativePath

abstract final class Pubspec {

  static const name = '${pubspecYaml['name']}';
  static const fullVersion = '$fullVersion';
  static const version = '$version';
  static const versionBuildNumber = $versionBuildNumber;
  static const description = '${pubspecYaml['description'] ?? ''}';
  static const repository = '${pubspecYaml['repository'] ?? ''}';
  static const homepage = '${pubspecYaml['homepage'] ?? ''}';
  static const issueTracker = '${pubspecYaml['issue_tracker'] ?? ''}';
  static const documentation = '${pubspecYaml['documentation'] ?? ''}';
  static const topics = <String>[${topics?.join(', ') ?? ''}];
}
''';

    final pubspecFileDestination = File(
      '$target/$_generatedPubspecDestination',
    );
    if (!pubspecFileDestination.existsSync()) {
      stderr.writeln(
        "The file ${pubspecFileDestination.path} doesn't exist. Please create it first."
        '\n\nCommand:\n'
        'touch ${pubspecFileDestination.path}',
      );
      exit(1);
    }
    await pubspecFileDestination.writeAsString(generatedDartFile);
    await Process.run('dart', ['format', pubspecFileDestination.path]);

    stdout.writeln(pubspecFileDestination.path);
  }
}
