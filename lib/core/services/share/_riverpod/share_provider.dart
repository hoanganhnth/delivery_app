import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../i_share_service.dart';
import '../share_service.dart';

part 'share_provider.g.dart';

@Riverpod(keepAlive: true)
IShareService shareService(Ref ref) {
  return ShareService();
}
