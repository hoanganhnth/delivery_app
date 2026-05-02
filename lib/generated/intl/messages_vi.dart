// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'vi';

  static String m0(productName) => "Đã thêm ${productName} vào giỏ hàng";

  static String m1(addressLabel) =>
      "Bạn có chắc muốn xóa địa chỉ \"${addressLabel}\"?";

  static String m2(count) => "${count} món";

  static String m3(restaurantName) => "Món ăn từ ${restaurantName}";

  static String m4(price) => "\$${price}";

  static String m5(rating) => "${rating}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("Giới Thiệu"),
    "account": MessageLookupByLibrary.simpleMessage("Tài Khoản"),
    "addAddress": MessageLookupByLibrary.simpleMessage("Thêm địa chỉ"),
    "addFirstAddress": MessageLookupByLibrary.simpleMessage(
      "Thêm địa chỉ đầu tiên",
    ),
    "addSomeDeliciousItems": MessageLookupByLibrary.simpleMessage(
      "Thêm một số món ngon để bắt đầu",
    ),
    "addToCart": MessageLookupByLibrary.simpleMessage("Thêm vào Giỏ"),
    "addedToCartLivestream": m0,
    "all": MessageLookupByLibrary.simpleMessage("Tất cả"),
    "appTitle": MessageLookupByLibrary.simpleMessage("Ứng dụng Giao Hàng"),
    "browseRestaurants": MessageLookupByLibrary.simpleMessage("Duyệt Nhà Hàng"),
    "cancel": MessageLookupByLibrary.simpleMessage("Hủy"),
    "cancelDelete": MessageLookupByLibrary.simpleMessage("Hủy"),
    "cancelOrder": MessageLookupByLibrary.simpleMessage("Hủy đơn hàng"),
    "cancelOrderActionBtn": MessageLookupByLibrary.simpleMessage("Hủy đơn"),
    "cancelOrderBtn": MessageLookupByLibrary.simpleMessage("Hủy đơn hàng"),
    "cancelOrderConfirm": MessageLookupByLibrary.simpleMessage(
      "Bạn có chắc chắn muốn hủy đơn hàng này không?",
    ),
    "cancelOrderError": MessageLookupByLibrary.simpleMessage(
      "Lỗi khi hủy đơn hàng",
    ),
    "cancelOrderFailed": MessageLookupByLibrary.simpleMessage(
      "Không thể hủy đơn hàng",
    ),
    "cancelOrderSuccess": MessageLookupByLibrary.simpleMessage(
      "Đã hủy đơn hàng thành công",
    ),
    "cancelPaymentWarningSubtitle": MessageLookupByLibrary.simpleMessage(
      "Bạn có chắc chắn muốn hủy quá trình thanh toán?",
    ),
    "cancelPaymentWarningTitle": MessageLookupByLibrary.simpleMessage(
      "Hủy thanh toán?",
    ),
    "cancelled": MessageLookupByLibrary.simpleMessage("Đã hủy"),
    "cannotAddItem": MessageLookupByLibrary.simpleMessage("Không thể thêm món"),
    "cart": MessageLookupByLibrary.simpleMessage("Giỏ Hàng"),
    "categories": MessageLookupByLibrary.simpleMessage("Danh Mục"),
    "chinese": MessageLookupByLibrary.simpleMessage("Món Trung Hoa"),
    "clear": MessageLookupByLibrary.simpleMessage("Xóa"),
    "clearCart": MessageLookupByLibrary.simpleMessage("Xóa Giỏ Hàng"),
    "clearCartMessage": MessageLookupByLibrary.simpleMessage(
      "Bạn có chắc chắn muốn xóa tất cả món ăn khỏi giỏ hàng không?",
    ),
    "clearCartTitle": MessageLookupByLibrary.simpleMessage("Xóa Giỏ Hàng"),
    "clearCurrentCart": MessageLookupByLibrary.simpleMessage(
      "Xóa giỏ hàng và thêm",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("Xác nhận"),
    "confirmCancelOrderSubtitle": MessageLookupByLibrary.simpleMessage(
      "Bạn có chắc chắn muốn hủy đơn hàng này không?\n\nHành động này không thể hoàn tác.",
    ),
    "confirmCancelOrderTitle": MessageLookupByLibrary.simpleMessage(
      "Xác nhận hủy đơn",
    ),
    "confirmDeleteAddress": MessageLookupByLibrary.simpleMessage(
      "Xác nhận xóa",
    ),
    "confirmDeleteAddressBtn": MessageLookupByLibrary.simpleMessage("Xóa"),
    "confirmDeleteAddressMessage": m1,
    "confirmed": MessageLookupByLibrary.simpleMessage("Đã xác nhận"),
    "continueShopping": MessageLookupByLibrary.simpleMessage(
      "Tiếp tục mua sắm",
    ),
    "conversationEnded": MessageLookupByLibrary.simpleMessage(
      "Đã kết thúc hội thoại",
    ),
    "coordinates": MessageLookupByLibrary.simpleMessage("Tọa độ"),
    "deliverFood": MessageLookupByLibrary.simpleMessage("DeliverFood"),
    "delivered": MessageLookupByLibrary.simpleMessage("Đã giao"),
    "delivering": MessageLookupByLibrary.simpleMessage("Đang giao"),
    "deliveryFee": MessageLookupByLibrary.simpleMessage("Phí giao hàng"),
    "differentRestaurantError": MessageLookupByLibrary.simpleMessage(
      "Bạn đã có món từ nhà hàng khác trong giỏ hàng. Vui lòng xóa giỏ hàng hiện tại để thêm món từ nhà hàng này.",
    ),
    "editAddress": MessageLookupByLibrary.simpleMessage("Chỉnh sửa"),
    "endBtn": MessageLookupByLibrary.simpleMessage("Kết thúc"),
    "endConversationBtn": MessageLookupByLibrary.simpleMessage(
      "Kết thúc hội thoại",
    ),
    "error": MessageLookupByLibrary.simpleMessage("Lỗi"),
    "errorPrefix": MessageLookupByLibrary.simpleMessage("Lỗi"),
    "estimatedDelivery": MessageLookupByLibrary.simpleMessage("Dự kiến giao"),
    "fastFood": MessageLookupByLibrary.simpleMessage("Đồ Ăn Nhanh"),
    "featuredRestaurants": MessageLookupByLibrary.simpleMessage(
      "Nhà Hàng Nổi Bật",
    ),
    "fetchLocationError": MessageLookupByLibrary.simpleMessage(
      "Không thể lấy vị trí",
    ),
    "fetchLocationSuccess": MessageLookupByLibrary.simpleMessage(
      "Đã lấy địa chỉ từ vị trí hiện tại",
    ),
    "freeDelivery": MessageLookupByLibrary.simpleMessage("Miễn Phí Giao Hàng"),
    "goBackBtn": MessageLookupByLibrary.simpleMessage("Quay lại"),
    "gotItBtn": MessageLookupByLibrary.simpleMessage("Đã hiểu"),
    "helloWorld": MessageLookupByLibrary.simpleMessage("Xin chào"),
    "help": MessageLookupByLibrary.simpleMessage("Trợ Giúp"),
    "hideOrderDetails": MessageLookupByLibrary.simpleMessage(
      "Ẩn Chi Tiết Đơn Hàng",
    ),
    "home": MessageLookupByLibrary.simpleMessage("Trang Chủ"),
    "indian": MessageLookupByLibrary.simpleMessage("Món Ấn Độ"),
    "italian": MessageLookupByLibrary.simpleMessage("Món Ý"),
    "items": m2,
    "itemsFrom": m3,
    "japanese": MessageLookupByLibrary.simpleMessage("Món Nhật"),
    "loading": MessageLookupByLibrary.simpleMessage("Đang tải..."),
    "login": MessageLookupByLibrary.simpleMessage("Đăng nhập"),
    "logout": MessageLookupByLibrary.simpleMessage("Đăng xuất"),
    "menu": MessageLookupByLibrary.simpleMessage("Thực Đơn"),
    "mexican": MessageLookupByLibrary.simpleMessage("Món Mexico"),
    "min": MessageLookupByLibrary.simpleMessage("phút"),
    "myAddresses": MessageLookupByLibrary.simpleMessage("Địa chỉ của tôi"),
    "newConversationStarted": MessageLookupByLibrary.simpleMessage(
      "Đã bắt đầu hội thoại mới",
    ),
    "noAddressFound": MessageLookupByLibrary.simpleMessage(
      "Chưa có địa chỉ nào",
    ),
    "noAddressFoundSubtitle": MessageLookupByLibrary.simpleMessage(
      "Thêm địa chỉ giao hàng để đặt món\nnhanh chóng hơn",
    ),
    "noBtn": MessageLookupByLibrary.simpleMessage("Không"),
    "noItemsFound": MessageLookupByLibrary.simpleMessage(
      "Không tìm thấy món ăn",
    ),
    "noOrders": MessageLookupByLibrary.simpleMessage("Không có đơn hàng"),
    "noOrdersMessage": MessageLookupByLibrary.simpleMessage(
      "Bạn chưa đặt đơn hàng nào. Hãy khám phá các nhà hàng và đặt đơn hàng đầu tiên!",
    ),
    "order": MessageLookupByLibrary.simpleMessage("Đơn hàng"),
    "orderCancelled": MessageLookupByLibrary.simpleMessage(
      "Đơn hàng đã được hủy thành công",
    ),
    "orderHistory": MessageLookupByLibrary.simpleMessage("Lịch Sử Đơn Hàng"),
    "orderSummary": MessageLookupByLibrary.simpleMessage("Tóm Tắt Đơn Hàng"),
    "orders": MessageLookupByLibrary.simpleMessage("Đơn Hàng"),
    "outOfStock": MessageLookupByLibrary.simpleMessage("Hết hàng"),
    "outOfStockItems": MessageLookupByLibrary.simpleMessage("Có món hết hàng"),
    "pending": MessageLookupByLibrary.simpleMessage("Chờ xác nhận"),
    "pizza": MessageLookupByLibrary.simpleMessage("Pizza"),
    "pleaseSelectAddress": MessageLookupByLibrary.simpleMessage(
      "Vui lòng chọn địa chỉ giao hàng",
    ),
    "popularNearYou": MessageLookupByLibrary.simpleMessage("Phổ Biến Gần Bạn"),
    "preparing": MessageLookupByLibrary.simpleMessage("Đang chuẩn bị"),
    "price": m4,
    "proceedToCheckout": MessageLookupByLibrary.simpleMessage(
      "Tiến hành thanh toán",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("Hồ Sơ"),
    "quantity": MessageLookupByLibrary.simpleMessage("SL"),
    "rateShipperBtn": MessageLookupByLibrary.simpleMessage("Đánh giá Shipper"),
    "rateShipperTitle": MessageLookupByLibrary.simpleMessage(
      "Đánh giá Shipper",
    ),
    "rating": m5,
    "ratingError": MessageLookupByLibrary.simpleMessage("Có lỗi xảy ra"),
    "ratingHint": MessageLookupByLibrary.simpleMessage(
      "Nhận xét của bạn (không bắt buộc)",
    ),
    "remove": MessageLookupByLibrary.simpleMessage("Xóa"),
    "restaurants": MessageLookupByLibrary.simpleMessage("Nhà Hàng"),
    "retry": MessageLookupByLibrary.simpleMessage("Thử lại"),
    "reviews": MessageLookupByLibrary.simpleMessage("Đánh Giá"),
    "searchHint": MessageLookupByLibrary.simpleMessage("Tìm kiếm món ăn..."),
    "searchRestaurants": MessageLookupByLibrary.simpleMessage(
      "Tìm kiếm nhà hàng",
    ),
    "serviceFee": MessageLookupByLibrary.simpleMessage("Phí dịch vụ"),
    "setAsDefault": MessageLookupByLibrary.simpleMessage("Đặt làm mặc định"),
    "setAsDefaultSubtitle": MessageLookupByLibrary.simpleMessage(
      "Địa chỉ này sẽ được chọn tự động khi đặt hàng",
    ),
    "setAsDefaultTitle": MessageLookupByLibrary.simpleMessage(
      "Đặt làm địa chỉ mặc định",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Cài Đặt"),
    "shoppingCart": MessageLookupByLibrary.simpleMessage("Giỏ Hàng"),
    "showOrderDetails": MessageLookupByLibrary.simpleMessage(
      "Hiện Chi Tiết Đơn Hàng",
    ),
    "signOut": MessageLookupByLibrary.simpleMessage("Đăng Xuất"),
    "startNewConversationBtn": MessageLookupByLibrary.simpleMessage(
      "Bắt đầu hội thoại mới",
    ),
    "submitRatingBtn": MessageLookupByLibrary.simpleMessage("Gửi đánh giá"),
    "subtotal": MessageLookupByLibrary.simpleMessage("Tạm tính"),
    "tax": MessageLookupByLibrary.simpleMessage("Thuế"),
    "test": MessageLookupByLibrary.simpleMessage("test"),
    "test2": MessageLookupByLibrary.simpleMessage("test2"),
    "test3": MessageLookupByLibrary.simpleMessage("test3"),
    "thai": MessageLookupByLibrary.simpleMessage("Món Thái"),
    "thanksForRating": MessageLookupByLibrary.simpleMessage(
      "Cảm ơn bạn đã đánh giá!",
    ),
    "top_restaurants": MessageLookupByLibrary.simpleMessage("Nhà hàng nổi bật"),
    "total": MessageLookupByLibrary.simpleMessage("Tổng cộng"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Thử Lại"),
    "unavailable": MessageLookupByLibrary.simpleMessage("Không có sẵn"),
    "update": MessageLookupByLibrary.simpleMessage("Cập nhật"),
    "viewAll": MessageLookupByLibrary.simpleMessage("Xem Tất Cả"),
    "vnpayPaymentTitle": MessageLookupByLibrary.simpleMessage(
      "Thanh toán VNPay",
    ),
    "yesBtn": MessageLookupByLibrary.simpleMessage("Có"),
    "yourCartIsEmpty": MessageLookupByLibrary.simpleMessage(
      "Giỏ hàng của bạn trống",
    ),
    "yourOrders": MessageLookupByLibrary.simpleMessage("Đơn Hàng Của Bạn"),
  };
}
