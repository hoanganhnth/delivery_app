import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract interface class SplashDelayPort {
  Future<void> wait(Duration duration);
}

class DartSplashDelay implements SplashDelayPort {
  const DartSplashDelay();

  @override
  Future<void> wait(Duration duration) => Future<void>.delayed(duration);
}

final splashDelayProvider = Provider<SplashDelayPort>(
  (ref) => const DartSplashDelay(),
);
