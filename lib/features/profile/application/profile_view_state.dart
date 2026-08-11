import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:equatable/equatable.dart';

import 'profile_effect.dart';

/// Render-ready profile data. It deliberately contains no repository or
/// Riverpod type so [ProfileView] can remain a pure UI component.
final class ProfileViewData extends Equatable {
  const ProfileViewData({this.displayName, this.email, this.initial});

  final String? displayName;
  final String? email;
  final String? initial;

  bool get hasUser => email != null && email!.isNotEmpty;

  @override
  List<Object?> get props => [displayName, email, initial];
}

final class ProfileViewState extends Equatable {
  const ProfileViewState({
    this.data = const ProfileViewData(),
    this.isLoading = false,
    this.isLoggingOut = false,
    this.errorMessage,
    this.effects = const <UiEffectEnvelope<ProfileEffect>>[],
  });

  final ProfileViewData data;
  final bool isLoading;
  final bool isLoggingOut;
  final String? errorMessage;
  final List<UiEffectEnvelope<ProfileEffect>> effects;

  ProfileViewState copyWith({
    ProfileViewData? data,
    bool? isLoading,
    bool? isLoggingOut,
    String? errorMessage,
    bool clearError = false,
    List<UiEffectEnvelope<ProfileEffect>>? effects,
  }) => ProfileViewState(
    data: data ?? this.data,
    isLoading: isLoading ?? this.isLoading,
    isLoggingOut: isLoggingOut ?? this.isLoggingOut,
    errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    effects: effects ?? this.effects,
  );

  @override
  List<Object?> get props => [
    data,
    isLoading,
    isLoggingOut,
    errorMessage,
    effects,
  ];
}
