// Or GNU/Linux
enum LinuxPackageManager({required final String executable}) {
  apt(executable: 'apt-get'),
  dnf(executable: 'dnf'),
  pacman(executable: 'pacman');

  /// Sets `DEBIAN_FRONTEND=noninteractive` to suppress
  /// post-installation prompts when using `apt`.
  ///
  /// Not needed for `dnf` (the argument `-y` usually skips the confirmation and questions)
  /// or `pacman` (`--noconfirm`).
  ///
  /// Should be used for commands that invoke `apt` directly or indirectly.
  static Map<String, String> get aptNonInteractiveEnv => {
    'DEBIAN_FRONTEND': 'noninteractive',
  };
}
