import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/session/auth_notifier.dart';
import '../application/session/auth_state.dart';
import '../application/session/session_port_adapter.dart';

import 'package:delivery_app/core/contracts/session_contract.dart';

/// Composition provider for the auth-owned neutral session boundary.
final sessionPortProvider = Provider<SessionPort>((ref) {
  final adapter = AuthSessionPort(ref.read(authProvider));
  ref.listen<AuthState>(authProvider, (_, next) {
    adapter.updateAuthState(next);
  });
  ref.onDispose(adapter.dispose);
  return adapter;
});
