import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../core/error/failures.dart';

part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState.initial() = AuthStateInitial;

  const factory AuthState.unauthenticated({
    @Default(false) bool isLoginLoading,
    @Default(false) bool isRegisterLoading,
    Failure? failure,
  }) = AuthStateUnauthenticated;

  const factory AuthState.authenticated({
    @Default('') String accessToken,
    @Default('') String refreshToken,
    @Default(false) bool isRefreshLoading,
    Failure? failure,
  }) = AuthStateAuthenticated;

  bool get isAuthenticated => this is AuthStateAuthenticated;
  bool get isLoginLoading =>
      maybeWhen(unauthenticated: (login, _, __) => login, orElse: () => false);
  bool get isRegisterLoading => maybeWhen(
      unauthenticated: (_, register, __) => register, orElse: () => false);
  bool get isRefreshLoading => maybeWhen(
      authenticated: (_, __, refresh, ___) => refresh, orElse: () => false);

  Failure? get failure => mapOrNull(
        unauthenticated: (s) => s.failure,
        authenticated: (s) => s.failure,
      );

  bool get hasError => failure != null;
  String? get errorMessage => failure?.message;

  String? get accessToken => mapOrNull(authenticated: (s) => s.accessToken);
  String? get refreshToken => mapOrNull(authenticated: (s) => s.refreshToken);
}
