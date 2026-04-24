import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../i_deep_link_service.dart';
import '../deep_link_service.dart';

part 'deep_link_provider.g.dart';

@Riverpod(keepAlive: true)
IDeepLinkService deepLinkService(Ref ref) {
  return DeepLinkService();
}
