import 'package:equatable/equatable.dart';
import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'settings_effect.dart';

final class SettingsViewState extends Equatable {
  const SettingsViewState({
    required this.isDarkMode,
    this.debugEnabled = false,
    this.themeOperation = UiOperationStatus.idle,
    this.effects = const <UiEffectEnvelope<SettingsEffect>>[],
  });

  final bool isDarkMode;
  final bool debugEnabled;
  final UiOperationStatus themeOperation;
  final List<UiEffectEnvelope<SettingsEffect>> effects;

  bool get isThemeUpdating => themeOperation.isRunning;

  SettingsViewState copyWith({
    bool? isDarkMode,
    bool? debugEnabled,
    UiOperationStatus? themeOperation,
    List<UiEffectEnvelope<SettingsEffect>>? effects,
  }) {
    return SettingsViewState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      debugEnabled: debugEnabled ?? this.debugEnabled,
      themeOperation: themeOperation ?? this.themeOperation,
      effects: effects ?? this.effects,
    );
  }

  @override
  List<Object?> get props => [
    isDarkMode,
    debugEnabled,
    themeOperation,
    effects,
  ];
}
