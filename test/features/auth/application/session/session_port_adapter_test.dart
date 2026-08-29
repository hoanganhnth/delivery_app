import 'package:flutter_test/flutter_test.dart';

import 'package:delivery_app/features/auth/application/session/auth_state.dart';
import 'package:delivery_app/features/auth/application/session/session_port_adapter.dart';

void main() {
  test('publishes authenticated token changes through SessionPort', () async {
    final port = AuthSessionPort(const AuthState.initial());
    addTearDown(port.dispose);
    final snapshots = <String?>[];
    final subscription = port.changes.listen(
      (snapshot) => snapshots.add(snapshot.accessToken),
    );
    addTearDown(subscription.cancel);

    port.updateAuthState(
      const AuthState.authenticated(
        accessToken: 'access-1',
        refreshToken: 'refresh-1',
      ),
    );

    await pumpEventQueue();
    expect(port.current.isAuthenticated, isTrue);
    expect(port.accessToken, 'access-1');
    expect(snapshots, ['access-1']);
  });

  test('identity updates do not require a Profile notifier import', () {
    final port = AuthSessionPort(const AuthState.initial());
    addTearDown(port.dispose);

    port.updateIdentity(authId: 10, profileId: 22, roles: {'USER'});

    expect(port.current.authId, 10);
    expect(port.current.profileId, 22);
    expect(port.current.roles, contains('USER'));
  });

  test('clears profile identity when the authenticated session ends', () {
    final port = AuthSessionPort(const AuthState.initial());
    addTearDown(port.dispose);

    port.updateIdentity(authId: 10, profileId: 22, roles: {'USER'});
    port.clearIdentity();

    expect(port.current.authId, isNull);
    expect(port.current.profileId, isNull);
    expect(port.current.roles, isEmpty);
  });
}
