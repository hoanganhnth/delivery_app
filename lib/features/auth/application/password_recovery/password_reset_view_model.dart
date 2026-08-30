import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/auth/di/auth_di_providers.dart';
import 'package:delivery_app/features/auth/domain/usecases/password_recovery_usecases.dart';

import 'password_reset_state.dart';

final passwordResetViewModelProvider =
    NotifierProvider.family<PasswordResetViewModel, PasswordResetState, String>(
      (token) => PasswordResetViewModel(token),
    );

class PasswordResetViewModel extends Notifier<PasswordResetState> {
  PasswordResetViewModel(this._token);

  final String _token;

  @override
  PasswordResetState build() => PasswordResetState(token: _token);

  void setNewPassword(String value) {
    state = state.copyWith(
      newPassword: value,
      isSubmitted: false,
      clearError: true,
    );
  }

  void setConfirmPassword(String value) {
    state = state.copyWith(
      confirmPassword: value,
      isSubmitted: false,
      clearError: true,
    );
  }

  Future<void> submit() async {
    if (state.isSubmitting) return;
    if (state.newPassword != state.confirmPassword) {
      state = state.copyWith(
        isSubmitted: false,
        errorMessage: 'Mật khẩu xác nhận không khớp.',
      );
      return;
    }

    state = state.copyWith(
      isSubmitting: true,
      isSubmitted: false,
      clearError: true,
    );
    final result = await ref.read(resetPasswordUseCaseProvider)(
      ResetPasswordParams(token: state.token, newPassword: state.newPassword),
    );
    if (!ref.mounted) return;
    state = result.match(
      (failure) => state.copyWith(
        isSubmitting: false,
        errorMessage: _failureMessage(failure),
      ),
      (_) => state.copyWith(isSubmitting: false, isSubmitted: true),
    );
  }

  String _failureMessage(Failure failure) => failure.maybeWhen(
    validation: (message) => message,
    network: (message) => message,
    server: (message) => message,
    orElse: () => 'Không thể đặt lại mật khẩu. Vui lòng thử lại.',
  );
}
