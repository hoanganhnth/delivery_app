import 'dart:convert';

import 'package:flutter/foundation.dart';

enum DebugLogLevel { debug, info, warning, error }

enum DebugLogKind { app, api }

enum DebugApiPhase { request, response, error }

class DebugLogEntry {
  const DebugLogEntry({
    required this.id,
    required this.timestamp,
    required this.level,
    required this.kind,
    required this.message,
    this.method,
    this.url,
    this.statusCode,
    this.durationMs,
    this.phase,
    this.requestBody,
    this.responseBody,
  });

  final int id;
  final DateTime timestamp;
  final DebugLogLevel level;
  final DebugLogKind kind;
  final String message;
  final String? method;
  final String? url;
  final int? statusCode;
  final int? durationMs;
  final DebugApiPhase? phase;
  final String? requestBody;
  final String? responseBody;
}

/// Bounded, debug-build-only diagnostic history for the in-app debug screen.
///
/// Payloads are normalized and recursively redacted before they enter the
/// buffer. Authorization headers are intentionally never accepted by this
/// API, so the store cannot accidentally render them.
class DebugLogStore extends ChangeNotifier {
  DebugLogStore({this.maxEntries = 300});

  static final DebugLogStore instance = DebugLogStore();

  final int maxEntries;
  final List<DebugLogEntry> _entries = <DebugLogEntry>[];
  int _nextId = 0;

  List<DebugLogEntry> get entries => List.unmodifiable(_entries);

  void recordMessage(
    DebugLogLevel level,
    Object? message, {
    DebugLogKind kind = DebugLogKind.app,
  }) {
    if (!kDebugMode) return;
    _append(
      DebugLogEntry(
        id: _nextId++,
        timestamp: DateTime.now(),
        level: level,
        kind: kind,
        message: _truncate(message?.toString() ?? '', 1200),
      ),
    );
  }

  void recordApi({
    required DebugApiPhase phase,
    required String method,
    required String url,
    int? statusCode,
    int? durationMs,
    Object? requestBody,
    Object? responseBody,
    Object? error,
  }) {
    if (!kDebugMode) return;

    final normalizedMethod = method.toUpperCase();
    final phaseLabel = switch (phase) {
      DebugApiPhase.request => 'REQUEST',
      DebugApiPhase.response => 'RESPONSE',
      DebugApiPhase.error => 'ERROR',
    };
    final status = statusCode == null ? '' : ' [$statusCode]';
    final errorText = error == null
        ? ''
        : ' ${_truncate(error.toString(), 600)}';

    _append(
      DebugLogEntry(
        id: _nextId++,
        timestamp: DateTime.now(),
        level: phase == DebugApiPhase.error
            ? DebugLogLevel.error
            : phase == DebugApiPhase.response
            ? DebugLogLevel.info
            : DebugLogLevel.debug,
        kind: DebugLogKind.api,
        message: '$phaseLabel $normalizedMethod $url$status$errorText',
        method: normalizedMethod,
        url: url,
        statusCode: statusCode,
        durationMs: durationMs,
        phase: phase,
        requestBody: _formatPayload(requestBody),
        responseBody: _formatPayload(responseBody),
      ),
    );
  }

  void clear() {
    if (_entries.isEmpty) return;
    _entries.clear();
    notifyListeners();
  }

  void _append(DebugLogEntry entry) {
    _entries.add(entry);
    if (_entries.length > maxEntries) {
      _entries.removeRange(0, _entries.length - maxEntries);
    }
    notifyListeners();
  }
}

String? _formatPayload(Object? value) {
  if (value == null) return null;

  Object normalized = value;
  if (value is String) {
    try {
      normalized = jsonDecode(value);
    } catch (_) {
      return _truncate(value, 4000);
    }
  }

  final redacted = _redact(normalized, 0);
  try {
    return _truncate(jsonEncode(redacted), 4000);
  } catch (_) {
    return _truncate(redacted.toString(), 4000);
  }
}

Object? _redact(Object? value, int depth) {
  if (depth > 5) return '[TRUNCATED]';
  if (value == null || value is num || value is bool) return value;
  if (value is String) return _truncate(value, 1000);
  if (value is List) {
    return value.take(50).map((item) => _redact(item, depth + 1)).toList();
  }
  if (value is Map) {
    return <String, Object?>{
      for (final entry in value.entries)
        entry.key.toString(): _isSensitiveKey(entry.key.toString())
            ? '[REDACTED]'
            : _redact(entry.value, depth + 1),
    };
  }
  return _truncate(value.toString(), 1000);
}

bool _isSensitiveKey(String key) {
  return RegExp(
    r'(authorization|access.?token|refresh.?token|password|secret|cookie|api.?key|fcm|device.?id)',
    caseSensitive: false,
  ).hasMatch(key);
}

String _truncate(String value, int maxLength) {
  if (value.length <= maxLength) return value;
  return '${value.substring(0, maxLength)}…';
}
