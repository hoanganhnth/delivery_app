import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:equatable/equatable.dart';

import 'splash_effect.dart';

enum SplashPhase { initializing, checkingAuth, navigating, error }

final class SplashViewState extends Equatable {
  const SplashViewState({
    this.phase = SplashPhase.initializing,
    this.effects = const <UiEffectEnvelope<SplashEffect>>[],
  });

  final SplashPhase phase;
  final List<UiEffectEnvelope<SplashEffect>> effects;

  bool get hasError => phase == SplashPhase.error;

  String get loadingMessage => switch (phase) {
    SplashPhase.initializing => 'Initializing app...',
    SplashPhase.checkingAuth => 'Checking authentication...',
    SplashPhase.navigating => 'Navigating...',
    SplashPhase.error => 'Something went wrong...',
  };

  SplashViewState copyWith({
    SplashPhase? phase,
    List<UiEffectEnvelope<SplashEffect>>? effects,
  }) => SplashViewState(
    phase: phase ?? this.phase,
    effects: effects ?? this.effects,
  );

  @override
  List<Object?> get props => [phase, effects];
}
