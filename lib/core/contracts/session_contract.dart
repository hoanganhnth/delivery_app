/// Neutral session identity exposed to features.
///
/// Feature code must not depend on AuthNotifier/AuthState. Auth owns the
/// implementation and app composition injects it through this port.
abstract interface class SessionPort extends AccessTokenProvider {
  SessionSnapshot get current;
  Stream<SessionSnapshot> get changes;
}

abstract interface class AccessTokenProvider {
  String? get accessToken;
}

/// App composition may enrich the auth-owned session with the profile
/// identity returned by the profile feature. Feature consumers only depend on
/// [SessionPort], never on this mutable sink.
abstract interface class SessionIdentitySink {
  void updateIdentity({int? authId, int? profileId, Set<String>? roles});
}

final class SessionSnapshot {
  SessionSnapshot({
    required this.isAuthenticated,
    this.authId,
    this.profileId,
    this.accessToken,
    Set<String> roles = const <String>{},
  }) : roles = Set.unmodifiable(roles);

  final bool isAuthenticated;
  final int? authId;
  final int? profileId;
  final String? accessToken;
  final Set<String> roles;

  bool get hasProfile => profileId != null && profileId! > 0;

  @override
  bool operator ==(Object other) =>
      other is SessionSnapshot &&
      other.isAuthenticated == isAuthenticated &&
      other.authId == authId &&
      other.profileId == profileId &&
      other.accessToken == accessToken &&
      _sameRoles(other.roles);

  @override
  int get hashCode => Object.hash(
    isAuthenticated,
    authId,
    profileId,
    accessToken,
    Object.hashAllUnordered(roles),
  );

  bool _sameRoles(Set<String> other) =>
      roles.length == other.length && roles.containsAll(other);
}
