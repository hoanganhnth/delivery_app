import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';

import '../logger/app_logger.dart';

/// Cloudinary service for media uploads
class CloudinaryService {
  late final CloudinaryPublic _cloudinary;
  
  // TODO: Replace with your Cloudinary credentials
  static const String _cloudName = 'djnfk8j8v';
  static const String _uploadPreset = 'delivery';
  
  CloudinaryService() {
    _cloudinary = CloudinaryPublic(_cloudName, _uploadPreset);
  }

  /// Upload image to Cloudinary
  Future<CloudinaryResponse> uploadImage(
    File file, {
    String? folder,
    String? publicId,
  }) async {
    try {
      AppLogger.d('Uploading image to Cloudinary: ${file.path}');
      
      final response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          file.path,
          folder: folder ?? 'support_chat',
          publicId: publicId,
          resourceType: CloudinaryResourceType.Image,
        ),
      );
      
      AppLogger.i('Image uploaded successfully: ${response.secureUrl}');
      return response;
    } catch (e, stackTrace) {
      AppLogger.e('Failed to upload image to Cloudinary', e, stackTrace);
      rethrow;
    }
  }

  /// Upload video to Cloudinary
  Future<CloudinaryResponse> uploadVideo(
    File file, {
    String? folder,
    String? publicId,
  }) async {
    try {
      AppLogger.d('Uploading video to Cloudinary: ${file.path}');
      
      final response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          file.path,
          folder: folder ?? 'support_chat',
          publicId: publicId,
          resourceType: CloudinaryResourceType.Video,
        ),
      );
      
      AppLogger.i('Video uploaded successfully: ${response.secureUrl}');
      return response;
    } catch (e, stackTrace) {
      AppLogger.e('Failed to upload video to Cloudinary', e, stackTrace);
      rethrow;
    }
  }

  /// Get optimized image URL with transformations
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

  /// Get video thumbnail URL
  String getVideoThumbnailUrl(
    String publicId, {
    int? width,
    int? height,
  }) {
    final transformations = <String>[];
    
    if (width != null) transformations.add('w_$width');
    if (height != null) transformations.add('h_$height');
    transformations.add('so_0'); // Start offset at 0 seconds
    
    final transformation = transformations.join(',');
    return 'https://res.cloudinary.com/$_cloudName/video/upload/$transformation/$publicId.jpg';
  }
}
