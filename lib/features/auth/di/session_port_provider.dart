import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/session/auth_notifier.dart';
import '../application/session/auth_state.dart';
import '../application/session/session_port_adapter.dart';

import 'package:delivery_app/core/contracts/session_contract.dart';

/// Auth implementation of the neutral session boundary.
///
/// Feature code must consume `core/contracts/session_port_provider.dart`.
/// This provider is only referenced from the application composition root.
final authSessionPortProvider = Provider<SessionPort>((ref) {
  final adapter = AuthSessionPort(ref.read(authProvider));
  ref.listen<AuthState>(authProvider, (_, next) {
    adapter.updateAuthState(next);
  });
  ref.onDispose(adapter.dispose);
  return adapter;
});
