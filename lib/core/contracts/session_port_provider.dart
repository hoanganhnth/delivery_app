import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'session_contract.dart';

/// Neutral session dependency consumed by feature application layers.
///
/// The default implementation is deliberately unauthenticated. Production
/// composition overrides it with the Auth-owned adapter; tests can provide a
/// deterministic fake without importing the Auth feature.
final sessionPortProvider = Provider<SessionPort>((ref) {
  return _UnavailableSessionPort.instance;
});

final class _UnavailableSessionPort implements SessionPort {
  const _UnavailableSessionPort._();

  static const instance = _UnavailableSessionPort._();

  static final _snapshot = SessionSnapshot(isAuthenticated: false);

  @override
  SessionSnapshot get current => _snapshot;

  @override
  Stream<SessionSnapshot> get changes => const Stream<SessionSnapshot>.empty();

  @override
  String? get accessToken => null;
}
