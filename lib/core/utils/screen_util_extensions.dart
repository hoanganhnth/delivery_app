import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Utility class cho các giá trị responsive phổ biến
/// Note: Sử dụng trực tiếp .w, .h, .sp, .r từ flutter_screenutil
class ResponsiveSize {
  // Spacing values
  static double get xs => 4.0.w;        // Extra small spacing
  static double get s => 8.0.w;         // Small spacing  
  static double get m => 16.0.w;        // Medium spacing (default)
  static double get l => 24.0.w;        // Large spacing
  static double get xl => 32.0.w;       // Extra large spacing
  static double get xxl => 48.0.w;      // Extra extra large spacing

  // Common heights
  static double get buttonHeight => 48.0.h;
  static double get textFieldHeight => 56.0.h;
  static double get appBarHeight => 56.0.h;
  static double get bottomNavHeight => 80.0.h;
  static double get cardHeight => 120.0.h;

  // Common widths
  static double get buttonWidth => 200.0.w;
  static double get iconSize => 24.0.w;
  static double get avatarSize => 40.0.w;

  // Border radius values
  static double get radiusXs => 4.0.r;
  static double get radiusS => 8.0.r;
  static double get radiusM => 12.0.r;
  static double get radiusL => 16.0.r;
  static double get radiusXl => 24.0.r;

  // Font sizes
  static double get fontXs => 10.0.sp;
  static double get fontS => 12.0.sp;
  static double get fontM => 14.0.sp;
  static double get fontL => 16.0.sp;
  static double get fontXl => 18.0.sp;
  static double get fontXxl => 20.0.sp;
  static double get fontTitle => 24.0.sp;
  static double get fontHeading => 32.0.sp;

  // Screen dimensions
  static double get screenWidth => ScreenUtil().screenWidth;
  static double get screenHeight => ScreenUtil().screenHeight;
  static double get statusBarHeight => ScreenUtil().statusBarHeight;
  static double get bottomBarHeight => ScreenUtil().bottomBarHeight;

  // Device type checks
  static bool get isMobile => screenWidth < 600;
  static bool get isTablet => screenWidth >= 600 && screenWidth < 1024;
  static bool get isDesktop => screenWidth >= 1024;

  // Orientation
  static bool get isPortrait => screenHeight > screenWidth;
  static bool get isLandscape => screenWidth > screenHeight;
}

/// Helper methods cho responsive design
class ScreenHelper {
  /// Kiểm tra xem có phải thiết bị nhỏ không (dưới design width)
  static bool get isSmallDevice => ResponsiveSize.screenWidth < 375;
  
  /// Kiểm tra xem có phải thiết bị lớn không (trên design width)
  static bool get isLargeDevice => ResponsiveSize.screenWidth > 375;

  /// Lấy padding an toàn cho màn hình
  static double get safeAreaTop => ScreenUtil().statusBarHeight;
  static double get safeAreaBottom => ScreenUtil().bottomBarHeight;

  /// Responsive value dựa trên kích thước màn hình
  static T responsive<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (ResponsiveSize.isDesktop && desktop != null) return desktop;
    if (ResponsiveSize.isTablet && tablet != null) return tablet;
    return mobile;
  }

  /// Adaptive spacing dựa trên device size
  static double adaptiveSpacing({
    double? small,
    double? medium,
    double? large,
  }) {
    if (isSmallDevice && small != null) return small;
    if (isLargeDevice && large != null) return large;
    return medium ?? ResponsiveSize.m;
  }
}
