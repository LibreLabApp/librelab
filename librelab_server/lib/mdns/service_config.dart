import 'package:meta/meta.dart';

@immutable
final class const MdnsServiceConfig({
  required final String instanceName,
  required final int port,
  required final String serviceType,
  required final List<String>? txtRecords,
});
