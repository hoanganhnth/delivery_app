import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';

class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final UserEntity? user;
  final Failure? failure;
  final bool isLoginLoading;
  final bool isRegisterLoading;
  final bool isRefreshLoading;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.user,
    this.failure,
    this.isLoginLoading = false,
    this.isRegisterLoading = false,
    this.isRefreshLoading = false,
  });

  // Computed properties
  bool get hasError => failure != null;
  String? get errorMessage => failure?.message;
  bool get hasUser => user != null;
  String? get accessToken => user?.accessToken;
  String? get refreshToken => user?.refreshToken;

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    UserEntity? user,
    Failure? failure,
    bool? isLoginLoading,
    bool? isRegisterLoading,
    bool? isRefreshLoading,
    bool clearFailure = false,
    bool clearUser = false,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: clearUser ? null : (user ?? this.user),
      failure: clearFailure ? null : (failure ?? this.failure),
      isLoginLoading: isLoginLoading ?? this.isLoginLoading,
      isRegisterLoading: isRegisterLoading ?? this.isRegisterLoading,
      isRefreshLoading: isRefreshLoading ?? this.isRefreshLoading,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthState &&
        other.isLoading == isLoading &&
        other.isAuthenticated == isAuthenticated &&
        other.user == user &&
        other.failure == failure &&
        other.isLoginLoading == isLoginLoading &&
        other.isRegisterLoading == isRegisterLoading &&
        other.isRefreshLoading == isRefreshLoading;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        isAuthenticated.hashCode ^
        user.hashCode ^
        failure.hashCode ^
        isLoginLoading.hashCode ^
        isRegisterLoading.hashCode ^
        isRefreshLoading.hashCode;
  }

  @override
  String toString() {
    return 'AuthState(isLoading: $isLoading, isAuthenticated: $isAuthenticated, hasUser: $hasUser, hasError: $hasError)';
  }
}
