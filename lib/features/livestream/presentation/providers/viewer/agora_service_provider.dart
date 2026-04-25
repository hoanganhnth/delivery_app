import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../services/agora_service.dart';

part 'agora_service_provider.g.dart';

/// Riverpod-managed AgoraService — auto-disposes with ref.onDispose
/// Family provider: one instance per livestreamId
@riverpod
IAgoraService agoraServiceForViewer(Ref ref, String livestreamId) {
  final service = AgoraService();

  // Auto-cleanup when provider is disposed (e.g. screen leaves)
  ref.onDispose(() {
    service.dispose();
  });

  return service;
}
