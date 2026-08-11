import 'package:equatable/equatable.dart';
import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'settings_effect.dart';

final class SettingsViewState extends Equatable {
  const SettingsViewState({
    required this.isDarkMode,
    this.themeOperation = UiOperationStatus.idle,
    this.effects = const <UiEffectEnvelope<SettingsEffect>>[],
  });

  final bool isDarkMode;
  final UiOperationStatus themeOperation;
  final List<UiEffectEnvelope<SettingsEffect>> effects;

  bool get isThemeUpdating => themeOperation.isRunning;

  SettingsViewState copyWith({
    bool? isDarkMode,
    UiOperationStatus? themeOperation,
    List<UiEffectEnvelope<SettingsEffect>>? effects,
  }) {
    return SettingsViewState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      themeOperation: themeOperation ?? this.themeOperation,
      effects: effects ?? this.effects,
    );
  }

  @override
  List<Object?> get props => [isDarkMode, themeOperation, effects];
}
