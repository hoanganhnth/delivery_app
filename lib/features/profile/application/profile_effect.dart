import 'package:equatable/equatable.dart';

sealed class ProfileEffect extends Equatable {
  const ProfileEffect();
}

final class ProfileNavigateOrders extends ProfileEffect {
  const ProfileNavigateOrders();

  @override
  List<Object?> get props => const [];
}

final class ProfileNavigateAddresses extends ProfileEffect {
  const ProfileNavigateAddresses();

  @override
  List<Object?> get props => const [];
}

final class ProfileNavigateSettings extends ProfileEffect {
  const ProfileNavigateSettings();

  @override
  List<Object?> get props => const [];
}

final class ProfileNavigateLogin extends ProfileEffect {
  const ProfileNavigateLogin();

  @override
  List<Object?> get props => const [];
}

final class ProfileShowError extends ProfileEffect {
  const ProfileShowError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
