import '../../../../core/error/failures.dart';

class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final Failure? failure;
  final bool isLoginLoading;
  final bool isRegisterLoading;
  final bool isRefreshLoading;
  final String? refreshToken;
  final String? accessToken;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.failure,
    this.isLoginLoading = false,
    this.isRegisterLoading = false,
    this.isRefreshLoading = false,
    this.refreshToken = '',
    this.accessToken = '',
  });

  // Computed properties
  bool get hasError => failure != null;
  String? get errorMessage => failure?.message;
  

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    Failure? failure,
    bool? isLoginLoading,
    bool? isRegisterLoading,
    bool? isRefreshLoading,
    bool clearFailure = false,
    String? refreshToken,
    String? accessToken,
    bool clearUser = false,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      failure: clearFailure ? null : (failure ?? this.failure),
      isLoginLoading: isLoginLoading ?? this.isLoginLoading,
      isRegisterLoading: isRegisterLoading ?? this.isRegisterLoading,
      isRefreshLoading: isRefreshLoading ?? this.isRefreshLoading,
      refreshToken: clearUser ? '' : (refreshToken ?? this.refreshToken),
      accessToken: clearUser ? '' : (accessToken ?? this.accessToken)

    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthState &&
        other.isLoading == isLoading &&
        other.isAuthenticated == isAuthenticated &&
        other.failure == failure &&
        other.isLoginLoading == isLoginLoading &&
        other.isRegisterLoading == isRegisterLoading &&
        other.isRefreshLoading == isRefreshLoading;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        isAuthenticated.hashCode ^
        failure.hashCode ^
        isLoginLoading.hashCode ^
        isRegisterLoading.hashCode ^
        isRefreshLoading.hashCode;
  }

  @override
  String toString() {
    return 'AuthState(isLoading: $isLoading, isAuthenticated: $isAuthenticated,  hasError: $hasError)';
  }
}
