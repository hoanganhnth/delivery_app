import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../routing/router_config.dart';
import '../../deep_link/_riverpod/deep_link_provider.dart';
import '../i_share_service.dart';
import '../share_service.dart';

part 'share_provider.g.dart';

@riverpod
IShareService shareService(Ref ref) {
  final config = ref.watch(routerConfigProvider);
  final deepLinkService = ref.watch(deepLinkServiceProvider);
  
  return ShareService(
    baseUrl: config.baseUrl ?? 'https://deliveryapp.com',
    deepLinkService: deepLinkService,
  );
}
