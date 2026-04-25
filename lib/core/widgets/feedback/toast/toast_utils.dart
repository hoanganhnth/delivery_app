import 'package:flutter/material.dart';
import '../../../../core/error/failures.dart';
import 'app_toast.dart';

/// Utility class cho các trường hợp sử dụng toast phổ biến
class ToastUtils {
  ToastUtils._();

  /// Hiển thị toast từ Failure
  static void showFailureToast(BuildContext context, Failure failure) {
    switch (failure.runtimeType) {
      case const (NetworkFailure):
        AppToast.showError(
          context: context,
          title: 'Lỗi kết nối',
          message: failure.message,
        );
        break;
      case const (ServerFailure):
        AppToast.showError(
          context: context,
          title: 'Lỗi server',
          message: failure.message,
        );
        break;
      case const (ValidationFailure):
        AppToast.showWarning(
          context: context,
          title: 'Dữ liệu không hợp lệ',
          message: failure.message,
        );
        break;
      default:
        AppToast.showError(
          context: context,
          title: 'Lỗi',
          message: failure.message,
        );
    }
  }

  /// Toast cho đăng nhập thành công
  static void showLoginSuccess(BuildContext context, {String? userName}) {
    final message = userName != null
        ? 'Chào mừng $userName!'
        : 'Đăng nhập thành công!';

    AppToast.showSuccess(
      context: context,
      title: 'Đăng nhập thành công',
      message: message,
    );
  }

  /// Toast cho đăng xuất thành công
  static void showLogoutSuccess(BuildContext context) {
    AppToast.showSuccess(
      context: context,
      title: 'Đăng xuất',
      message: 'Đã đăng xuất thành công!',
    );
  }

  /// Toast cho đăng ký thành công
  static void showRegisterSuccess(BuildContext context) {
    AppToast.showSuccess(
      context: context,
      title: 'Đăng ký thành công',
      message: 'Tài khoản đã được tạo thành công!',
    );
  }

  /// Toast cho cập nhật thành công
  static void showUpdateSuccess(BuildContext context, {String? itemName}) {
    final message = itemName != null
        ? 'Đã cập nhật $itemName thành công!'
        : 'Cập nhật thành công!';

    AppToast.showSuccess(context: context, title: 'Cập nhật', message: message);
  }

  /// Toast cho xóa thành công
  static void showDeleteSuccess(BuildContext context, {String? itemName}) {
    final message = itemName != null
        ? 'Đã xóa $itemName thành công!'
        : 'Xóa thành công!';

    AppToast.showSuccess(context: context, title: 'Xóa', message: message);
  }

  /// Toast cho thêm vào giỏ hàng
  static void showAddToCartSuccess(BuildContext context, {String? itemName}) {
    final message = itemName != null
        ? 'Đã thêm $itemName vào giỏ hàng!'
        : 'Đã thêm vào giỏ hàng!';

    AppToast.showSuccess(context: context, title: 'Giỏ hàng', message: message);
  }

  /// Toast cho đặt hàng thành công
  static void showOrderSuccess(BuildContext context, {String? orderId}) {
    final message = orderId != null
        ? 'Đơn hàng #$orderId đã được đặt thành công!'
        : 'Đặt hàng thành công!';

    AppToast.showSuccess(context: context, title: 'Đặt hàng', message: message);
  }

  /// Toast cho thanh toán thành công
  static void showPaymentSuccess(BuildContext context) {
    AppToast.showSuccess(
      context: context,
      title: 'Thanh toán',
      message: 'Thanh toán thành công!',
    );
  }

  /// Toast cho lỗi mạng
  static void showNetworkError(BuildContext context) {
    AppToast.showError(
      context: context,
      title: 'Lỗi kết nối',
      message: 'Vui lòng kiểm tra kết nối mạng và thử lại!',
    );
  }

  /// Toast cho lỗi server
  static void showServerError(BuildContext context) {
    AppToast.showError(
      context: context,
      title: 'Lỗi server',
      message: 'Có lỗi xảy ra từ phía server. Vui lòng thử lại sau!',
    );
  }

  /// Toast cho cảnh báo phiên hết hạn
  static void showSessionExpiredWarning(BuildContext context) {
    AppToast.showWarning(
      context: context,
      title: 'Phiên đăng nhập',
      message: 'Phiên đăng nhập sắp hết hạn. Vui lòng đăng nhập lại!',
      duration: const Duration(seconds: 6),
    );
  }

  /// Toast cho thông báo cập nhật app
  static void showAppUpdateInfo(BuildContext context) {
    AppToast.showInfo(
      context: context,
      title: 'Cập nhật ứng dụng',
      message: 'Có phiên bản mới của ứng dụng. Vui lòng cập nhật!',
      duration: const Duration(seconds: 6),
    );
  }

  /// Toast cho thông báo bảo trì
  static void showMaintenanceInfo(BuildContext context) {
    AppToast.showInfo(
      context: context,
      title: 'Bảo trì hệ thống',
      message:
          'Hệ thống đang được bảo trì. Một số tính năng có thể bị ảnh hưởng.',
      duration: const Duration(seconds: 8),
    );
  }

  /// Toast cho copy thành công
  static void showCopySuccess(BuildContext context, {String? content}) {
    final message = content != null
        ? 'Đã copy "$content" vào clipboard!'
        : 'Đã copy vào clipboard!';

    AppToast.showSuccess(
      context: context,
      title: 'Copy',
      message: message,
      duration: const Duration(seconds: 2),
    );
  }

  /// Toast cho lưu thành công
  static void showSaveSuccess(BuildContext context) {
    AppToast.showSuccess(
      context: context,
      title: 'Lưu',
      message: 'Đã lưu thành công!',
      duration: const Duration(seconds: 2),
    );
  }

  /// Toast order thanh cong
  static void showOrderPlacedSuccess(BuildContext context, {String? orderId}) {
    final message = orderId != null
        ? 'Đơn hàng #$orderId đã được đặt thành công!'
        : 'Đặt hàng thành công!';
    AppToast.showSuccess(context: context, title: 'Đặt hàng', message: message);
  }

  /// Toast order that bai
  static void showOrderPlacedError(
    BuildContext context, {
    String? message,
    String? orderId,
  }) {
    final mess =
        message ??
        (orderId != null
            ? 'Đặt đơn hàng #$orderId thất bại. Vui lòng thử lại!'
            : 'Đặt hàng thất bại. Vui lòng thử lại!');
    AppToast.showError(context: context, title: 'Đặt hàng', message: mess);
  }

  // Address management toasts
  /// Toast cho thêm địa chỉ thành công
  static void showAddressAddSuccess(BuildContext context, {String? addressLabel}) {
    final message = addressLabel != null
        ? 'Đã thêm địa chỉ "$addressLabel" thành công!'
        : 'Đã thêm địa chỉ mới thành công!';

    AppToast.showSuccess(
      context: context,
      title: 'Thêm địa chỉ',
      message: message,
    );
  }

  /// Toast cho cập nhật địa chỉ thành công
  static void showAddressUpdateSuccess(BuildContext context, {String? addressLabel}) {
    final message = addressLabel != null
        ? 'Đã cập nhật địa chỉ "$addressLabel" thành công!'
        : 'Đã cập nhật địa chỉ thành công!';

    AppToast.showSuccess(
      context: context,
      title: 'Cập nhật địa chỉ',
      message: message,
    );
  }

  /// Toast cho xóa địa chỉ thành công
  static void showAddressDeleteSuccess(BuildContext context, {String? addressLabel}) {
    final message = addressLabel != null
        ? 'Đã xóa địa chỉ "$addressLabel" thành công!'
        : 'Đã xóa địa chỉ thành công!';

    AppToast.showSuccess(
      context: context,
      title: 'Xóa địa chỉ',
      message: message,
    );
  }

  /// Toast cho đặt địa chỉ mặc định thành công
  static void showAddressSetDefaultSuccess(BuildContext context, {String? addressLabel}) {
    final message = addressLabel != null
        ? 'Đã đặt "$addressLabel" làm địa chỉ mặc định!'
        : 'Đã đặt làm địa chỉ mặc định!';

    AppToast.showSuccess(
      context: context,
      title: 'Địa chỉ mặc định',
      message: message,
    );
  }

  /// Toast cho lỗi thêm địa chỉ
  static void showAddressAddError(BuildContext context, {String? message}) {
    final errorMessage = message ?? 'Thêm địa chỉ thất bại. Vui lòng thử lại!';

    AppToast.showError(
      context: context,
      title: 'Thêm địa chỉ',
      message: errorMessage,
    );
  }

  /// Toast cho lỗi cập nhật địa chỉ
  static void showAddressUpdateError(BuildContext context, {String? message}) {
    final errorMessage = message ?? 'Cập nhật địa chỉ thất bại. Vui lòng thử lại!';

    AppToast.showError(
      context: context,
      title: 'Cập nhật địa chỉ',
      message: errorMessage,
    );
  }

  /// Toast cho lỗi xóa địa chỉ
  static void showAddressDeleteError(BuildContext context, {String? message}) {
    final errorMessage = message ?? 'Xóa địa chỉ thất bại. Vui lòng thử lại!';

    AppToast.showError(
      context: context,
      title: 'Xóa địa chỉ',
      message: errorMessage,
    );
  }

  /// Toast cho lỗi đặt địa chỉ mặc định
  static void showAddressSetDefaultError(BuildContext context, {String? message}) {
    final errorMessage = message ?? 'Đặt địa chỉ mặc định thất bại. Vui lòng thử lại!';

    AppToast.showError(
      context: context,
      title: 'Địa chỉ mặc định',
      message: errorMessage,
    );
  }

  /// Toast cho lỗi tải danh sách địa chỉ
  static void showAddressLoadError(BuildContext context, {String? message}) {
    final errorMessage = message ?? 'Tải danh sách địa chỉ thất bại. Vui lòng thử lại!';

    AppToast.showError(
      context: context,
      title: 'Tải địa chỉ',
      message: errorMessage,
    );
  }
}
