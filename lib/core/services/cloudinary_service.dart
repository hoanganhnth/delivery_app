import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import '../logger/app_logger.dart';
import 'i_image_upload_service.dart';

/// Cloudinary implementation of IImageUploadService
class CloudinaryService implements IImageUploadService {
  late final CloudinaryPublic _cloudinary;
  
  static const String _cloudName = 'djnfk8j8v';
  static const String _uploadPreset = 'delivery';
  
  CloudinaryService() {
    _cloudinary = CloudinaryPublic(_cloudName, _uploadPreset);
  }

  @override
  Future<CloudinaryResponse> uploadImage(
    File file, {
    String? folder,
    String? publicId,
  }) async {
    try {
      AppLogger.debug('Uploading image to Cloudinary: ${file.path}');
      
      final response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          file.path,
          folder: folder ?? 'support_chat',
          publicId: publicId,
          resourceType: CloudinaryResourceType.Image,
        ),
      );
      
      AppLogger.info('Image uploaded successfully: ${response.secureUrl}');
      return response;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to upload image to Cloudinary', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<CloudinaryResponse> uploadVideo(
    File file, {
    String? folder,
    String? publicId,
  }) async {
    try {
      AppLogger.debug('Uploading video to Cloudinary: ${file.path}');
      
      final response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          file.path,
          folder: folder ?? 'support_chat',
          publicId: publicId,
          resourceType: CloudinaryResourceType.Video,
        ),
      );
      
      AppLogger.info('Video uploaded successfully: ${response.secureUrl}');
      return response;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to upload video to Cloudinary', e, stackTrace);
      rethrow;
    }
  }

  @override
  String getOptimizedImageUrl(
    String publicId, {
    int? width,
    int? height,
    String quality = 'auto',
    String format = 'auto',
  }) {
    final transformations = <String>[];
    
    if (width != null) transformations.add('w_$width');
    if (height != null) transformations.add('h_$height');
    transformations.add('q_$quality');
    transformations.add('f_$format');
    
    final transformation = transformations.join(',');
    return 'https://res.cloudinary.com/$_cloudName/image/upload/$transformation/$publicId';
  }

  @override
  String getVideoThumbnailUrl(
    String publicId, {
    int? width,
    int? height,
  }) {
    final transformations = <String>[];
    
    if (width != null) transformations.add('w_$width');
    if (height != null) transformations.add('h_$height');
    transformations.add('so_0'); 
    
    final transformation = transformations.join(',');
    return 'https://res.cloudinary.com/$_cloudName/video/upload/$transformation/$publicId.jpg';
  }
}
