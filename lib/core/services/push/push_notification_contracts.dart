class PushMessageEnvelope {
  const PushMessageEnvelope({required this.data, this.title, this.body});

  final Map<String, Object?> data;
  final String? title;
  final String? body;
}

class PushWakeSignal {
  const PushWakeSignal({
    required this.notificationId,
    required this.type,
    this.relatedEntityId,
    this.relatedEntityType,
  });

  final int notificationId;
  final String type;
  final int? relatedEntityId;
  final String? relatedEntityType;

  Map<String, Object?> toJson() => {
    'notificationId': notificationId,
    'type': type,
    'relatedEntityId': relatedEntityId,
    'relatedEntityType': relatedEntityType,
  };

  static PushWakeSignal? fromJson(Object? value) {
    if (value is! Map) return null;
    final map = Map<String, Object?>.from(value);
    return parsePushWakeSignal(PushMessageEnvelope(data: map));
  }

  @override
  bool operator ==(Object other) =>
      other is PushWakeSignal &&
      other.notificationId == notificationId &&
      other.type == type &&
      other.relatedEntityId == relatedEntityId &&
      other.relatedEntityType == relatedEntityType;

  @override
  int get hashCode =>
      Object.hash(notificationId, type, relatedEntityId, relatedEntityType);
}

const customerPushWakeTypes = <String>{
  'ORDER_CREATED',
  'DELIVERY_PENDING',
  'DELIVERY_FINDING_SHIPPER',
  'DELIVERY_WAIT_SHIPPER_CONFIRM',
  'DELIVERY_SHIPPER_NOT_FOUND',
  'DELIVERY_ASSIGNED',
  'DELIVERY_PICKED_UP',
  'DELIVERY_DELIVERING',
  'DELIVERY_DELIVERED',
  'DELIVERY_CANCELLED',
};

PushWakeSignal? parsePushWakeSignal(
  PushMessageEnvelope message, {
  Set<String> acceptedTypes = customerPushWakeTypes,
}) {
  final notificationId = _positiveInt(message.data['notificationId']);
  final type = _text(message.data['type']);
  if (notificationId == null || type == null || !acceptedTypes.contains(type)) {
    return null;
  }

  final rawRelatedId = message.data['relatedEntityId'];
  final relatedEntityId = _positiveInt(rawRelatedId);
  final relatedEntityType = _text(message.data['relatedEntityType']);
  if (rawRelatedId != null &&
      (relatedEntityId == null || relatedEntityType == null)) {
    return null;
  }

  return PushWakeSignal(
    notificationId: notificationId,
    type: type,
    relatedEntityId: relatedEntityId,
    relatedEntityType: relatedEntityType,
  );
}

int? _positiveInt(Object? value) {
  final parsed = switch (value) {
    int number => number,
    String text => int.tryParse(text.trim()),
    _ => null,
  };
  return parsed != null && parsed > 0 ? parsed : null;
}

String? _text(Object? value) {
  if (value is! String) return null;
  final normalized = value.trim();
  return normalized.isEmpty ? null : normalized;
}

abstract interface class PushNativePort {
  Future<bool> requestPermission();
  Future<String?> getToken();
  Future<void> deleteToken();
  Future<PushMessageEnvelope?> getInitialMessage();
  Stream<String> get tokenRefreshes;
  Stream<PushMessageEnvelope> get foregroundMessages;
  Stream<PushMessageEnvelope> get openedMessages;
}

abstract interface class PushTokenBackendPort {
  Future<void> registerToken(String token);
  Future<void> unregisterToken(String token);
}

abstract interface class PushPersistencePort {
  Future<String?> getLastSyncedToken();
  Future<void> setLastSyncedToken(String? token);
  Future<bool> claimLive(PushWakeSignal signal);
  Future<bool> recordPending(PushWakeSignal signal);
  Future<List<PushWakeSignal>> consumePending();
  Future<void> clearPending();
}

abstract interface class PushPresentationPort {
  Future<void> initialize();
  Future<void> showForeground(
    PushWakeSignal signal, {
    String? title,
    String? body,
  });
}

Future<bool> recordBackgroundPushWake(
  PushMessageEnvelope message,
  PushPersistencePort persistence,
) async {
  final signal = parsePushWakeSignal(message);
  return signal != null && await persistence.recordPending(signal);
}
