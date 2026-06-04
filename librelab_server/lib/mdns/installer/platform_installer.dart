abstract interface class MdnsPlatformInstaller {
  Future<bool> isInstalled();
  Future<void> install();

  String get promptMessage;
}
