sealed class SplashIntent {
  const SplashIntent();
}

final class SplashStartRequested extends SplashIntent {
  const SplashStartRequested();
}

final class SplashRetryRequested extends SplashIntent {
  const SplashRetryRequested();
}

final class SplashEffectConsumed extends SplashIntent {
  const SplashEffectConsumed(this.effectId);

  final int effectId;
}
