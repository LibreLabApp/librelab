import 'package:meta/meta.dart';

@immutable
class const LabSettings({
  required final String? labName,
  required final bool loginDisabled,
  required final String? labImageId,
  required final DateTime updatedAt,
});
