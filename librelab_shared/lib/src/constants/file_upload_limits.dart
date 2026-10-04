abstract final class FileUploadLimits {
  /// The maximum image file size used for image uploads.
  ///
  /// This is an application-level value for client-side pre-validation and
  /// improved user experience. It is not part of the API contract, and its
  /// value may differ between client and server versions. Clients must still
  /// handle the server rejecting a file for exceeding its configured maximum
  /// size.
  static const maxImageSizeBytes = 10 * 1024 * 1024; // 10 MiB
}
