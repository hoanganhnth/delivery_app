/// Serializes Agora engine lifecycle changes so overlapping join/leave calls
/// cannot initialize, release, or replace the same engine concurrently.
final class AgoraMediaOperationQueue {
  Future<void> _tail = Future<void>.value();

  Future<void> run(Future<void> Function() operation) {
    final result = _tail.then((_) => operation());
    _tail = result.then<void>((_) {}, onError: (_, _) {});
    return result;
  }
}
