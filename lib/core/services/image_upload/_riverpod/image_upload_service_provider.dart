import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../i_image_upload_service.dart';
import '../cloudinary_image_upload_service.dart';

part 'image_upload_service_provider.g.dart';

@Riverpod(keepAlive: true)
IImageUploadService imageUploadService(Ref ref) {
  return CloudinaryImageUploadService();
}
