const _name = 'FLATPAK_APP_ID';

const bool isFlatpak = bool.hasEnvironment(_name);

const String? flatpakId = isFlatpak ? String.fromEnvironment(_name) : null;
