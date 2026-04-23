import 'dart:io';

/// Interface for image upload service
abstract class IImageUploadService {
  /// Upload image
  Future<dynamic> uploadImage(
    File file, {
    String? folder,
    String? publicId,
  });

  /// Upload video
  Future<dynamic> uploadVideo(
    File file, {
    String? folder,
    String? publicId,
  });

  /// Get optimized image URL
  String getOptimizedImageUrl(
    String publicId, {
    int? width,
    int? height,
    String quality = 'auto',
    String format = 'auto',
  });

  /// Get video thumbnail URL
  String getVideoThumbnailUrl(
    String publicId, {
    int? width,
    int? height,
  });
}
