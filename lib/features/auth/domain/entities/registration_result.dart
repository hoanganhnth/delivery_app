import 'package:equatable/equatable.dart';

/// Result of the public Auth -> User registration handoff.
///
/// A registration can create an Auth identity while the paired User profile
/// request is interrupted. `profileCreated` makes that state explicit instead
/// of reporting a false full-registration success. The recovery handle is kept
/// only in memory by the caller; it must not be written to plain local storage.
class RegistrationResult extends Equatable {
  const RegistrationResult({
    required this.principalId,
    required this.profileCreated,
    this.registrationHandle,
    this.expiresAt,
    this.lifecycleStatus,
    this.recoveryMessage,
  });

  final int principalId;
  final bool profileCreated;
  final String? registrationHandle;
  final DateTime? expiresAt;
  final String? lifecycleStatus;
  final String? recoveryMessage;

  bool get canRecover =>
      !profileCreated &&
      registrationHandle != null &&
      registrationHandle!.isNotEmpty &&
      (expiresAt == null || DateTime.now().isBefore(expiresAt!));

  @override
  List<Object?> get props => [
    principalId,
    profileCreated,
    registrationHandle,
    expiresAt,
    lifecycleStatus,
    recoveryMessage,
  ];
}
