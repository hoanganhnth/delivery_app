import 'dart:async';

/// Deduplicates Agora renewal callbacks and prevents a late token from being
/// applied after the media session has been disposed.
final class AgoraTokenRenewal {
  AgoraTokenRenewal({
    required Future<String> Function() fetchToken,
    required Future<void> Function(String token) applyToken,
    required void Function() onFailure,
  }) : _fetchToken = fetchToken,
       _applyToken = applyToken,
       _onFailure = onFailure;

  final Future<String> Function() _fetchToken;
  final Future<void> Function(String token) _applyToken;
  final void Function() _onFailure;
  Future<void>? _inFlight;
  bool _disposed = false;

  void request() {
    if (_disposed || _inFlight != null) return;
    final operation = _renew();
    _inFlight = operation;
    unawaited(
      operation.whenComplete(() {
        if (identical(_inFlight, operation)) _inFlight = null;
      }),
    );
  }

  Future<void> _renew() async {
    try {
      final token = await _fetchToken();
      if (_disposed) return;
      await _applyToken(token);
    } catch (_) {
      if (!_disposed) _onFailure();
    }
  }

  void dispose() {
    _disposed = true;
  }
}
