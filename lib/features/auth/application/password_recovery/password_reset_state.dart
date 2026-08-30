import 'package:equatable/equatable.dart';

final class PasswordResetState extends Equatable {
  const PasswordResetState({
    required this.token,
    this.newPassword = '',
    this.confirmPassword = '',
    this.isSubmitting = false,
    this.isSubmitted = false,
    this.errorMessage,
  });

  final String token;
  final String newPassword;
  final String confirmPassword;
  final bool isSubmitting;
  final bool isSubmitted;
  final String? errorMessage;

  PasswordResetState copyWith({
    String? newPassword,
    String? confirmPassword,
    bool? isSubmitting,
    bool? isSubmitted,
    String? errorMessage,
    bool clearError = false,
  }) {
    return PasswordResetState(
      token: token,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    token,
    newPassword,
    confirmPassword,
    isSubmitting,
    isSubmitted,
    errorMessage,
  ];
}
