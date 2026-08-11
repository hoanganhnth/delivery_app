sealed class ProfileIntent {
  const ProfileIntent();
}

final class ProfileOrdersRequested extends ProfileIntent {
  const ProfileOrdersRequested();
}

final class ProfileAddressesRequested extends ProfileIntent {
  const ProfileAddressesRequested();
}

final class ProfileSettingsRequested extends ProfileIntent {
  const ProfileSettingsRequested();
}

final class ProfileLogoutRequested extends ProfileIntent {
  const ProfileLogoutRequested();
}

final class ProfileRefreshRequested extends ProfileIntent {
  const ProfileRefreshRequested();
}

final class ProfileEffectConsumed extends ProfileIntent {
  const ProfileEffectConsumed(this.effectId);

  final int effectId;
}
