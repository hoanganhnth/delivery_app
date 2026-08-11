import 'package:equatable/equatable.dart';

sealed class SplashEffect extends Equatable {
  const SplashEffect();
}

final class SplashNavigateToMain extends SplashEffect {
  const SplashNavigateToMain();

  @override
  List<Object?> get props => const [];
}

final class SplashNavigateToLogin extends SplashEffect {
  const SplashNavigateToLogin();

  @override
  List<Object?> get props => const [];
}
