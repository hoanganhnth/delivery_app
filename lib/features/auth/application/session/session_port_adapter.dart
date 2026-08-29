import 'dart:async';

import 'package:delivery_app/core/contracts/session_contract.dart';

import 'auth_state.dart';

/// Auth-owned adapter that projects AuthState into the neutral SessionPort.
/// Profile identity can be enriched by app composition after profile bootstrap.
final class AuthSessionPort implements SessionPort, SessionIdentitySink {
  AuthSessionPort(AuthState initial)
    : _authState = initial,
      _changes = StreamController<SessionSnapshot>.broadcast() {
    _snapshot = _toSnapshot(initial);
  }

  AuthState _authState;
  late SessionSnapshot _snapshot;
  final StreamController<SessionSnapshot> _changes;
  int? _authId;
  int? _profileId;
  Set<String> _roles = const <String>{};

  @override
  SessionSnapshot get current => _snapshot;

  @override
  Stream<SessionSnapshot> get changes => _changes.stream;

  @override
  String? get accessToken => _snapshot.accessToken;

  void updateAuthState(AuthState next) {
    if (_authState == next && _snapshot == _toSnapshot(next)) return;
    _authState = next;
    _publish(_toSnapshot(next));
  }

  @override
  void updateIdentity({int? authId, int? profileId, Set<String>? roles}) {
    _authId = authId ?? _authId;
    _profileId = profileId ?? _profileId;
    if (roles != null) _roles = Set.unmodifiable(roles);
    _publish(_toSnapshot(_authState));
  }

  @override
  void clearIdentity() {
    _authId = null;
    _profileId = null;
    _roles = const <String>{};
    _publish(_toSnapshot(_authState));
  }

  Future<void> dispose() => _changes.close();

  void _publish(SessionSnapshot next) {
    if (next == _snapshot) return;
    _snapshot = next;
    if (!_changes.isClosed) _changes.add(next);
  }

  SessionSnapshot _toSnapshot(AuthState state) => SessionSnapshot(
    isAuthenticated: state.isAuthenticated,
    authId: _authId,
    profileId: _profileId,
    accessToken: state.accessToken,
    roles: _roles,
  );
}
