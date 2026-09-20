import 'package:librelab_server/utils/json_types.dart';

/// A domain object that can provide a human-readable audit snapshot.
abstract interface class Auditable {
  /// Returns a human-readable snapshot for audit history.
  ///
  /// The structure is descriptive rather than a stable schema and may change
  /// over time.
  JsonMap toAuditJson();
}
