class PasswordRecoveryState {
  const PasswordRecoveryState({
    this.email = '',
    this.isSubmitting = false,
    this.isSubmitted = false,
    this.errorMessage,
  });

  final String email;
  final bool isSubmitting;
  final bool isSubmitted;
  final String? errorMessage;

  PasswordRecoveryState copyWith({
    String? email,
    bool? isSubmitting,
    bool? isSubmitted,
    String? errorMessage,
    bool clearError = false,
  }) {
    return PasswordRecoveryState(
      email: email ?? this.email,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
