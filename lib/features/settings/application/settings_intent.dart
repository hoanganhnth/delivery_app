sealed class SettingsIntent {
  const SettingsIntent();
}

final class SettingsThemeToggled extends SettingsIntent {
  const SettingsThemeToggled();
}

final class SettingsAboutRequested extends SettingsIntent {
  const SettingsAboutRequested();
}

final class SettingsSupportRequested extends SettingsIntent {
  const SettingsSupportRequested();
}

final class SettingsDebugToolsRequested extends SettingsIntent {
  const SettingsDebugToolsRequested();
}

final class SettingsEffectConsumed extends SettingsIntent {
  const SettingsEffectConsumed(this.effectId);

  final int effectId;
}
