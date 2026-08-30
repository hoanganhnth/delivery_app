import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/auth/di/auth_di_providers.dart';
import 'package:delivery_app/features/auth/domain/usecases/password_recovery_usecases.dart';

import 'password_recovery_state.dart';

final passwordRecoveryViewModelProvider = NotifierProvider<
  PasswordRecoveryViewModel,
  PasswordRecoveryState
>(PasswordRecoveryViewModel.new);

class PasswordRecoveryViewModel extends Notifier<PasswordRecoveryState> {
  @override
  PasswordRecoveryState build() => const PasswordRecoveryState();

  void setEmail(String value) {
    state = state.copyWith(email: value, isSubmitted: false, clearError: true);
  }

  Future<void> submit() async {
    if (state.isSubmitting) return;
    state = state.copyWith(isSubmitting: true, isSubmitted: false, clearError: true);
    final result = await ref.read(requestPasswordResetUseCaseProvider)(
      RequestPasswordResetParams(email: state.email),
    );
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
    orElse: () => 'Không thể gửi yêu cầu. Vui lòng thử lại.',
  );
}
