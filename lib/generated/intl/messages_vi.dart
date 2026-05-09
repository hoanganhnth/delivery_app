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

  static String m1(count) => "Đã chọn ${count} mã";

  static String m2(count) =>
      "${count} món trong giỏ hàng đã hết hàng hoặc không còn khả dụng. Vui lòng xoá những món này trước khi đặt hàng.";

  static String m3(addressLabel) =>
      "Bạn có chắc muốn xóa địa chỉ \"${addressLabel}\"?";

  static String m4(count) => "${count} món";

  static String m5(restaurantName) => "Món ăn từ ${restaurantName}";

  static String m6(days) => "${days} ngày trước";

  static String m7(hours) => "${hours} giờ trước";

  static String m8(minutes) => "${minutes} phút trước";

  static String m9(price) => "\$${price}";

  static String m10(rating) => "${rating}";

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
    "addressAdd": MessageLookupByLibrary.simpleMessage("Thêm địa chỉ"),
    "addressAddTitle": MessageLookupByLibrary.simpleMessage("Thêm địa chỉ mới"),
    "addressAutoFillLocation": MessageLookupByLibrary.simpleMessage(
      "Tự động điền địa chỉ từ GPS",
    ),
    "addressCity": MessageLookupByLibrary.simpleMessage("Tỉnh/Thành phố"),
    "addressCityHint": MessageLookupByLibrary.simpleMessage(
      "Nhập tỉnh/thành phố",
    ),
    "addressDelete": MessageLookupByLibrary.simpleMessage("Xóa"),
    "addressDetails": MessageLookupByLibrary.simpleMessage("Chi tiết địa chỉ"),
    "addressDistrict": MessageLookupByLibrary.simpleMessage("Quận/Huyện"),
    "addressDistrictHint": MessageLookupByLibrary.simpleMessage(
      "Nhập quận/huyện",
    ),
    "addressEditTitle": MessageLookupByLibrary.simpleMessage("Sửa địa chỉ"),
    "addressGetCurrentLocation": MessageLookupByLibrary.simpleMessage(
      "Lấy vị trí hiện tại",
    ),
    "addressGettingLocation": MessageLookupByLibrary.simpleMessage(
      "Đang lấy vị trí...",
    ),
    "addressHome": MessageLookupByLibrary.simpleMessage("Nhà riêng"),
    "addressInfo": MessageLookupByLibrary.simpleMessage("Thông tin địa chỉ"),
    "addressLabel": MessageLookupByLibrary.simpleMessage("Nhãn địa chỉ"),
    "addressLabelHint": MessageLookupByLibrary.simpleMessage(
      "Ví dụ: Nhà riêng, Công ty...",
    ),
    "addressLabelRequired": MessageLookupByLibrary.simpleMessage(
      "Vui lòng nhập nhãn địa chỉ",
    ),
    "addressLine": MessageLookupByLibrary.simpleMessage("Địa chỉ chi tiết"),
    "addressLineHint": MessageLookupByLibrary.simpleMessage(
      "Số nhà, tên đường...",
    ),
    "addressLineRequired": MessageLookupByLibrary.simpleMessage(
      "Vui lòng nhập địa chỉ chi tiết",
    ),
    "addressOther": MessageLookupByLibrary.simpleMessage("Khác"),
    "addressPhone": MessageLookupByLibrary.simpleMessage("Số điện thoại"),
    "addressPhoneHint": MessageLookupByLibrary.simpleMessage(
      "Nhập số điện thoại người nhận",
    ),
    "addressPhoneInvalid": MessageLookupByLibrary.simpleMessage(
      "Số điện thoại không hợp lệ",
    ),
    "addressPhoneRequired": MessageLookupByLibrary.simpleMessage(
      "Vui lòng nhập số điện thoại",
    ),
    "addressPostalCode": MessageLookupByLibrary.simpleMessage("Mã bưu điện"),
    "addressPostalCodeHint": MessageLookupByLibrary.simpleMessage("Tùy chọn"),
    "addressRecipientHint": MessageLookupByLibrary.simpleMessage(
      "Nhập tên người nhận hàng",
    ),
    "addressRecipientName": MessageLookupByLibrary.simpleMessage(
      "Tên người nhận",
    ),
    "addressRecipientRequired": MessageLookupByLibrary.simpleMessage(
      "Vui lòng nhập tên người nhận",
    ),
    "addressRequiredField": MessageLookupByLibrary.simpleMessage("Bắt buộc"),
    "addressSave": MessageLookupByLibrary.simpleMessage("Lưu thay đổi"),
    "addressSchool": MessageLookupByLibrary.simpleMessage("Trường học"),
    "addressType": MessageLookupByLibrary.simpleMessage("Loại địa chỉ"),
    "addressWard": MessageLookupByLibrary.simpleMessage("Phường/Xã"),
    "addressWardHint": MessageLookupByLibrary.simpleMessage("Nhập phường/xã"),
    "addressWork": MessageLookupByLibrary.simpleMessage("Công ty"),
    "all": MessageLookupByLibrary.simpleMessage("Tất cả"),
    "alreadyHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Đã có tài khoản? ",
    ),
    "anonymous": MessageLookupByLibrary.simpleMessage("Ẩn danh"),
    "appTitle": MessageLookupByLibrary.simpleMessage("Ứng dụng Giao Hàng"),
    "backToLogin": MessageLookupByLibrary.simpleMessage("Quay lại đăng nhập"),
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
    "checkoutAddressHint": MessageLookupByLibrary.simpleMessage(
      "Nhập địa chỉ chi tiết...",
    ),
    "checkoutAddressRequired": MessageLookupByLibrary.simpleMessage(
      "Vui lòng chọn địa chỉ giao hàng",
    ),
    "checkoutAddressTitle": MessageLookupByLibrary.simpleMessage(
      "Địa chỉ giao hàng",
    ),
    "checkoutDeliveryAddress": MessageLookupByLibrary.simpleMessage(
      "Địa chỉ giao hàng",
    ),
    "checkoutDiscount": MessageLookupByLibrary.simpleMessage("Giảm giá"),
    "checkoutErrorPrice": MessageLookupByLibrary.simpleMessage(
      "Không thể lấy giá từ server. Nhấn để thử lại.",
    ),
    "checkoutLoadingPrice": MessageLookupByLibrary.simpleMessage(
      "Đang tính toán giá...",
    ),
    "checkoutMapFeatureSoon": MessageLookupByLibrary.simpleMessage(
      "Tính năng bản đồ sẽ sớm được cập nhật",
    ),
    "checkoutNotesTitle": MessageLookupByLibrary.simpleMessage(
      "Ghi chú (không bắt buộc)",
    ),
    "checkoutOrderBtn": MessageLookupByLibrary.simpleMessage("Đặt hàng"),
    "checkoutOrderDetailsTitle": MessageLookupByLibrary.simpleMessage(
      "Chi tiết đơn hàng",
    ),
    "checkoutPayBtn": MessageLookupByLibrary.simpleMessage("Thanh toán"),
    "checkoutPaymentMethodTitle": MessageLookupByLibrary.simpleMessage(
      "Phương thức thanh toán",
    ),
    "checkoutPromoTitle": MessageLookupByLibrary.simpleMessage(
      "Khuyến mãi / Voucher",
    ),
    "checkoutSelectOnMap": MessageLookupByLibrary.simpleMessage(
      "Chọn trên bản đồ",
    ),
    "checkoutSelectPromo": MessageLookupByLibrary.simpleMessage(
      "Chọn hoặc nhập mã",
    ),
    "checkoutSelectedPromo": m1,
    "checkoutShippingFee": MessageLookupByLibrary.simpleMessage(
      "Phí giao hàng",
    ),
    "checkoutSubtotal": MessageLookupByLibrary.simpleMessage("Tiền hàng"),
    "checkoutTitle": MessageLookupByLibrary.simpleMessage("Thanh toán"),
    "checkoutTotal": MessageLookupByLibrary.simpleMessage("Tổng thanh toán"),
    "checkoutUnavailableItemsDesc": m2,
    "checkoutUnavailableItemsTitle": MessageLookupByLibrary.simpleMessage(
      "Có món hết hàng",
    ),
    "checkoutUnderstood": MessageLookupByLibrary.simpleMessage("Đã hiểu"),
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
    "confirmDeleteAddressMessage": m3,
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "XÁC NHẬN MẬT KHẨU",
    ),
    "confirmYourPassword": MessageLookupByLibrary.simpleMessage(
      "Vui lòng xác nhận mật khẩu",
    ),
    "confirmed": MessageLookupByLibrary.simpleMessage("Đã xác nhận"),
    "connected": MessageLookupByLibrary.simpleMessage("Kết nối"),
    "connecting": MessageLookupByLibrary.simpleMessage("Đang kết nối..."),
    "continueShopping": MessageLookupByLibrary.simpleMessage(
      "Tiếp tục mua sắm",
    ),
    "conversationEnded": MessageLookupByLibrary.simpleMessage(
      "Đã kết thúc hội thoại",
    ),
    "coordinates": MessageLookupByLibrary.simpleMessage("Tọa độ"),
    "createAccount": MessageLookupByLibrary.simpleMessage("Tạo tài khoản"),
    "createAccountBtn": MessageLookupByLibrary.simpleMessage("TẠO TÀI KHOẢN"),
    "deliverFood": MessageLookupByLibrary.simpleMessage("DeliverFood"),
    "delivered": MessageLookupByLibrary.simpleMessage("Đã giao"),
    "deliveredSuccess": MessageLookupByLibrary.simpleMessage(
      "Giao hàng thành công!",
    ),
    "deliveredSuccessMessage": MessageLookupByLibrary.simpleMessage(
      "Đơn hàng của bạn đã được giao đến nơi.",
    ),
    "delivering": MessageLookupByLibrary.simpleMessage("Đang giao"),
    "deliveryFee": MessageLookupByLibrary.simpleMessage("Phí giao hàng"),
    "differentRestaurantError": MessageLookupByLibrary.simpleMessage(
      "Bạn đã có món từ nhà hàng khác trong giỏ hàng. Vui lòng xóa giỏ hàng hiện tại để thêm món từ nhà hàng này.",
    ),
    "disconnected": MessageLookupByLibrary.simpleMessage("Mất kết nối"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Chưa có tài khoản? ",
    ),
    "editAddress": MessageLookupByLibrary.simpleMessage("Chỉnh sửa"),
    "emailAddress": MessageLookupByLibrary.simpleMessage("ĐỊA CHỈ EMAIL"),
    "emailHint": MessageLookupByLibrary.simpleMessage("chef@amberhearth.com"),
    "endBtn": MessageLookupByLibrary.simpleMessage("Kết thúc"),
    "endConversationBtn": MessageLookupByLibrary.simpleMessage(
      "Kết thúc hội thoại",
    ),
    "enterEmail": MessageLookupByLibrary.simpleMessage("Vui lòng nhập email"),
    "enterPassword": MessageLookupByLibrary.simpleMessage(
      "Vui lòng nhập mật khẩu",
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
    "findingDriver": MessageLookupByLibrary.simpleMessage(
      "Đang tìm tài xế giao hàng",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Quên mật khẩu?"),
    "freeDelivery": MessageLookupByLibrary.simpleMessage("Miễn Phí Giao Hàng"),
    "fullName": MessageLookupByLibrary.simpleMessage("HỌ VÀ TÊN"),
    "fullNameHint": MessageLookupByLibrary.simpleMessage("Nguyễn Văn A"),
    "goBackBtn": MessageLookupByLibrary.simpleMessage("Quay lại"),
    "gotItBtn": MessageLookupByLibrary.simpleMessage("Đã hiểu"),
    "helloWorld": MessageLookupByLibrary.simpleMessage("Xin chào"),
    "help": MessageLookupByLibrary.simpleMessage("Trợ Giúp"),
    "hideOrderDetails": MessageLookupByLibrary.simpleMessage(
      "Ẩn Chi Tiết Đơn Hàng",
    ),
    "home": MessageLookupByLibrary.simpleMessage("Trang Chủ"),
    "indian": MessageLookupByLibrary.simpleMessage("Món Ấn Độ"),
    "invalidEmail": MessageLookupByLibrary.simpleMessage(
      "Vui lòng nhập email hợp lệ",
    ),
    "italian": MessageLookupByLibrary.simpleMessage("Món Ý"),
    "items": m4,
    "itemsFrom": m5,
    "japanese": MessageLookupByLibrary.simpleMessage("Món Nhật"),
    "joinTheHearth": MessageLookupByLibrary.simpleMessage("THAM GIA HEARTH"),
    "livestreamEnded": MessageLookupByLibrary.simpleMessage(
      "Livestream đã kết thúc",
    ),
    "livestreamOngoing": MessageLookupByLibrary.simpleMessage(
      "Livestream đang diễn ra",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Đang tải..."),
    "login": MessageLookupByLibrary.simpleMessage("Đăng nhập"),
    "loginSubtitle": MessageLookupByLibrary.simpleMessage(
      "Hãy tận hưởng khoảnh khắc. Đăng nhập vào căn bếp của bạn.",
    ),
    "loginSuccess": MessageLookupByLibrary.simpleMessage(
      "Đăng nhập thành công!",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Đăng xuất"),
    "mapWillShowWhenDriverAccepts": MessageLookupByLibrary.simpleMessage(
      "Bản đồ sẽ hiển thị khi tài xế nhận đơn",
    ),
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
    "noTrackingInfo": MessageLookupByLibrary.simpleMessage(
      "Chưa có thông tin theo dõi",
    ),
    "notificationEmptyDesc": MessageLookupByLibrary.simpleMessage(
      "Các thông báo sẽ xuất hiện ở đây",
    ),
    "notificationEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "Chưa có thông báo nào",
    ),
    "notificationMarkAllRead": MessageLookupByLibrary.simpleMessage(
      "Đọc tất cả",
    ),
    "notificationTimeDays": m6,
    "notificationTimeHours": m7,
    "notificationTimeJustNow": MessageLookupByLibrary.simpleMessage("Vừa xong"),
    "notificationTimeMinutes": m8,
    "notificationTitle": MessageLookupByLibrary.simpleMessage("Thông báo"),
    "order": MessageLookupByLibrary.simpleMessage("Đơn hàng"),
    "orderCancelled": MessageLookupByLibrary.simpleMessage(
      "Đơn hàng đã được hủy thành công",
    ),
    "orderHistory": MessageLookupByLibrary.simpleMessage("Lịch Sử Đơn Hàng"),
    "orderSummary": MessageLookupByLibrary.simpleMessage("Tóm Tắt Đơn Hàng"),
    "orders": MessageLookupByLibrary.simpleMessage("Đơn Hàng"),
    "outOfStock": MessageLookupByLibrary.simpleMessage("Hết hàng"),
    "outOfStockItems": MessageLookupByLibrary.simpleMessage("Có món hết hàng"),
    "password": MessageLookupByLibrary.simpleMessage("MẬT KHẨU"),
    "passwordHelper": MessageLookupByLibrary.simpleMessage(
      "Phải có ít nhất 8 ký tự với sự kết hợp của các biểu tượng.",
    ),
    "passwordHint": MessageLookupByLibrary.simpleMessage("••••••••"),
    "passwordMinLength": MessageLookupByLibrary.simpleMessage(
      "Mật khẩu phải có ít nhất 6 ký tự",
    ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Mật khẩu không khớp",
    ),
    "paymentInfo": MessageLookupByLibrary.simpleMessage("Thông tin thanh toán"),
    "paymentMethodText": MessageLookupByLibrary.simpleMessage(
      "Phương thức thanh toán",
    ),
    "pending": MessageLookupByLibrary.simpleMessage("Chờ xác nhận"),
    "pinnedUppercase": MessageLookupByLibrary.simpleMessage("ĐANG GHIM"),
    "pizza": MessageLookupByLibrary.simpleMessage("Pizza"),
    "pleaseSelectAddress": MessageLookupByLibrary.simpleMessage(
      "Vui lòng chọn địa chỉ giao hàng",
    ),
    "popularNearYou": MessageLookupByLibrary.simpleMessage("Phổ Biến Gần Bạn"),
    "preparing": MessageLookupByLibrary.simpleMessage("Đang chuẩn bị"),
    "price": m9,
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("Chính sách Bảo mật"),
    "proceedToCheckout": MessageLookupByLibrary.simpleMessage(
      "Tiến hành thanh toán",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("Hồ Sơ"),
    "profileChangePassword": MessageLookupByLibrary.simpleMessage(
      "Đổi mật khẩu",
    ),
    "profileChangePasswordDesc": MessageLookupByLibrary.simpleMessage(
      "Cập nhật mật khẩu định kỳ",
    ),
    "profileCustomerSupport": MessageLookupByLibrary.simpleMessage(
      "Hỗ trợ khách hàng",
    ),
    "profileCustomerSupportDesc": MessageLookupByLibrary.simpleMessage(
      "Chat với CSKH 24/7",
    ),
    "profileEditProfile": MessageLookupByLibrary.simpleMessage(
      "Chỉnh sửa hồ sơ",
    ),
    "profileEditProfileDesc": MessageLookupByLibrary.simpleMessage(
      "Cập nhật thông tin cá nhân",
    ),
    "profileHelpFAQ": MessageLookupByLibrary.simpleMessage("Trợ giúp & FAQ"),
    "profileHelpFAQDesc": MessageLookupByLibrary.simpleMessage(
      "Câu hỏi thường gặp",
    ),
    "profileLogout": MessageLookupByLibrary.simpleMessage("Đăng xuất"),
    "profileMyAddresses": MessageLookupByLibrary.simpleMessage(
      "Địa chỉ của tôi",
    ),
    "profileMyAddressesDesc": MessageLookupByLibrary.simpleMessage(
      "Quản lý địa chỉ giao hàng",
    ),
    "profilePaymentMethods": MessageLookupByLibrary.simpleMessage(
      "Phương thức thanh toán",
    ),
    "profilePaymentMethodsDesc": MessageLookupByLibrary.simpleMessage(
      "Thêm hoặc xóa thẻ",
    ),
    "profileSecurity": MessageLookupByLibrary.simpleMessage("Bảo mật"),
    "profileSupport": MessageLookupByLibrary.simpleMessage("Hỗ trợ"),
    "profileTermsPolicies": MessageLookupByLibrary.simpleMessage(
      "Điều khoản & Chính sách",
    ),
    "profileTermsPoliciesDesc": MessageLookupByLibrary.simpleMessage(
      "Quy định sử dụng",
    ),
    "profileTitle": MessageLookupByLibrary.simpleMessage("Tài khoản"),
    "quantity": MessageLookupByLibrary.simpleMessage("SL"),
    "rateShipperBtn": MessageLookupByLibrary.simpleMessage("Đánh giá Shipper"),
    "rateShipperTitle": MessageLookupByLibrary.simpleMessage(
      "Đánh giá Shipper",
    ),
    "rating": m10,
    "ratingError": MessageLookupByLibrary.simpleMessage("Có lỗi xảy ra"),
    "ratingHint": MessageLookupByLibrary.simpleMessage(
      "Nhận xét của bạn (không bắt buộc)",
    ),
    "register": MessageLookupByLibrary.simpleMessage("Đăng ký"),
    "registerFailed": MessageLookupByLibrary.simpleMessage(
      "Đăng ký thất bại. Vui lòng thử lại sau.",
    ),
    "registerSubtitle": MessageLookupByLibrary.simpleMessage(
      "Bước vào thế giới trải nghiệm ẩm thực tinh hoa. Đăng ký để bắt đầu hành trình của bạn với Amber Hearth.",
    ),
    "registerSuccess": MessageLookupByLibrary.simpleMessage(
      "Đăng ký thành công!",
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
    "settingsAbout": MessageLookupByLibrary.simpleMessage("Thông tin"),
    "settingsAboutApp": MessageLookupByLibrary.simpleMessage("Về ứng dụng"),
    "settingsAboutAppDesc": MessageLookupByLibrary.simpleMessage(
      "Phiên bản 1.0.0",
    ),
    "settingsAppearance": MessageLookupByLibrary.simpleMessage("Giao diện"),
    "settingsClearCache": MessageLookupByLibrary.simpleMessage("Xóa cache"),
    "settingsClearCacheDesc": MessageLookupByLibrary.simpleMessage(
      "Giải phóng bộ nhớ",
    ),
    "settingsCookieTracking": MessageLookupByLibrary.simpleMessage(
      "Cookie & Tracking",
    ),
    "settingsCookieTrackingDesc": MessageLookupByLibrary.simpleMessage(
      "Quản lý preferences",
    ),
    "settingsDangerZone": MessageLookupByLibrary.simpleMessage(
      "Vùng nguy hiểm",
    ),
    "settingsDarkMode": MessageLookupByLibrary.simpleMessage("Chế độ tối"),
    "settingsDarkModeDesc": MessageLookupByLibrary.simpleMessage(
      "Bảo vệ mắt trong đêm",
    ),
    "settingsDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Xóa tài khoản",
    ),
    "settingsDeleteAccountDesc": MessageLookupByLibrary.simpleMessage(
      "Xóa vĩnh viễn tất cả dữ liệu",
    ),
    "settingsLanguage": MessageLookupByLibrary.simpleMessage("Ngôn ngữ"),
    "settingsLanguageTitle": MessageLookupByLibrary.simpleMessage(
      "Chọn ngôn ngữ",
    ),
    "settingsNotifications": MessageLookupByLibrary.simpleMessage("Thông báo"),
    "settingsOrderUpdates": MessageLookupByLibrary.simpleMessage(
      "Cập nhật đơn hàng",
    ),
    "settingsOrderUpdatesDesc": MessageLookupByLibrary.simpleMessage(
      "Trạng thái giao hàng real-time",
    ),
    "settingsPrivacy": MessageLookupByLibrary.simpleMessage("Quyền riêng tư"),
    "settingsPrivacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Chính sách bảo mật",
    ),
    "settingsPrivacyPolicyDesc": MessageLookupByLibrary.simpleMessage(
      "Cách chúng tôi bảo vệ dữ liệu",
    ),
    "settingsPromotions": MessageLookupByLibrary.simpleMessage("Khuyến mãi"),
    "settingsPromotionsDesc": MessageLookupByLibrary.simpleMessage(
      "Ưu đãi và deal hấp dẫn",
    ),
    "settingsPushNotifications": MessageLookupByLibrary.simpleMessage(
      "Thông báo đẩy",
    ),
    "settingsPushNotificationsDesc": MessageLookupByLibrary.simpleMessage(
      "Nhận thông báo từ ứng dụng",
    ),
    "settingsRateApp": MessageLookupByLibrary.simpleMessage(
      "Đánh giá ứng dụng",
    ),
    "settingsRateAppDesc": MessageLookupByLibrary.simpleMessage(
      "Chia sẻ trải nghiệm của bạn",
    ),
    "settingsShareApp": MessageLookupByLibrary.simpleMessage(
      "Chia sẻ ứng dụng",
    ),
    "settingsShareAppDesc": MessageLookupByLibrary.simpleMessage(
      "Giới thiệu bạn bè",
    ),
    "settingsTermsOfUse": MessageLookupByLibrary.simpleMessage(
      "Điều khoản sử dụng",
    ),
    "settingsTermsOfUseDesc": MessageLookupByLibrary.simpleMessage(
      "Quy định và điều kiện",
    ),
    "settingsTitle": MessageLookupByLibrary.simpleMessage("Cài đặt"),
    "shipperNotStarted": MessageLookupByLibrary.simpleMessage(
      "Shipper chưa bắt đầu giao hàng cho đơn này",
    ),
    "shoppingCart": MessageLookupByLibrary.simpleMessage("Giỏ Hàng"),
    "showOrderDetails": MessageLookupByLibrary.simpleMessage(
      "Hiện Chi Tiết Đơn Hàng",
    ),
    "signIn": MessageLookupByLibrary.simpleMessage("ĐĂNG NHẬP"),
    "signInWithGoogle": MessageLookupByLibrary.simpleMessage(
      "Đăng nhập với Google",
    ),
    "signOut": MessageLookupByLibrary.simpleMessage("Đăng Xuất"),
    "startNewConversationBtn": MessageLookupByLibrary.simpleMessage(
      "Bắt đầu hội thoại mới",
    ),
    "submitRatingBtn": MessageLookupByLibrary.simpleMessage("Gửi đánh giá"),
    "subtotal": MessageLookupByLibrary.simpleMessage("Tạm tính"),
    "supportAttachFile": MessageLookupByLibrary.simpleMessage("Tệp"),
    "supportAttachImage": MessageLookupByLibrary.simpleMessage("Ảnh"),
    "supportAttachVideo": MessageLookupByLibrary.simpleMessage("Video"),
    "supportAttachmentError": MessageLookupByLibrary.simpleMessage(
      "Không thể chọn file đính kèm",
    ),
    "supportAttachmentTitle": MessageLookupByLibrary.simpleMessage("Đính kèm"),
    "supportCancel": MessageLookupByLibrary.simpleMessage("Hủy"),
    "supportChatHint": MessageLookupByLibrary.simpleMessage("Nhập tin nhắn..."),
    "supportChatTitle": MessageLookupByLibrary.simpleMessage(
      "Hỗ trợ khách hàng",
    ),
    "supportConversationEnded": MessageLookupByLibrary.simpleMessage(
      "Đã kết thúc hội thoại",
    ),
    "supportConversationEndedBanner": MessageLookupByLibrary.simpleMessage(
      "Hội thoại đã kết thúc",
    ),
    "supportCreateNew": MessageLookupByLibrary.simpleMessage("Tạo mới"),
    "supportDateToday": MessageLookupByLibrary.simpleMessage("Hôm nay"),
    "supportDateYesterday": MessageLookupByLibrary.simpleMessage("Hôm qua"),
    "supportEnd": MessageLookupByLibrary.simpleMessage("Kết thúc"),
    "supportEndConfirmationDesc": MessageLookupByLibrary.simpleMessage(
      "Bạn có chắc muốn kết thúc hội thoại này? Bạn có thể bắt đầu hội thoại mới bất kỳ lúc nào.",
    ),
    "supportEndConfirmationTitle": MessageLookupByLibrary.simpleMessage(
      "Kết thúc hội thoại",
    ),
    "supportEndConversation": MessageLookupByLibrary.simpleMessage(
      "Kết thúc hội thoại",
    ),
    "supportErrorTitle": MessageLookupByLibrary.simpleMessage("Đã xảy ra lỗi"),
    "supportFooterClosed": MessageLookupByLibrary.simpleMessage(
      "Hội thoại đã kết thúc. Nhấn menu để tạo mới.",
    ),
    "supportNewConversation": MessageLookupByLibrary.simpleMessage(
      "Bắt đầu hội thoại mới",
    ),
    "supportNewConversationStarted": MessageLookupByLibrary.simpleMessage(
      "Đã bắt đầu hội thoại mới",
    ),
    "supportRetry": MessageLookupByLibrary.simpleMessage("Thử lại"),
    "supportStatusActive": MessageLookupByLibrary.simpleMessage(
      "Đang hoạt động",
    ),
    "supportVideoSizeError": MessageLookupByLibrary.simpleMessage(
      "Video không được quá 10MB",
    ),
    "supportWelcome": MessageLookupByLibrary.simpleMessage("Chào mừng bạn!"),
    "supportWelcomeDesc": MessageLookupByLibrary.simpleMessage(
      "Gửi tin nhắn để bắt đầu cuộc trò chuyện\nvới đội ngũ hỗ trợ",
    ),
    "tax": MessageLookupByLibrary.simpleMessage("Thuế"),
    "termsAnd": MessageLookupByLibrary.simpleMessage(" và "),
    "termsDot": MessageLookupByLibrary.simpleMessage(" của Amber Hearth."),
    "termsOfService": MessageLookupByLibrary.simpleMessage(
      "Điều khoản Dịch vụ",
    ),
    "termsPrefix": MessageLookupByLibrary.simpleMessage(
      "Bằng cách tạo tài khoản, bạn đồng ý với ",
    ),
    "test": MessageLookupByLibrary.simpleMessage("test"),
    "test2": MessageLookupByLibrary.simpleMessage("test2"),
    "test3": MessageLookupByLibrary.simpleMessage("test3"),
    "thai": MessageLookupByLibrary.simpleMessage("Món Thái"),
    "thanksForRating": MessageLookupByLibrary.simpleMessage(
      "Cảm ơn bạn đã đánh giá!",
    ),
    "top_restaurants": MessageLookupByLibrary.simpleMessage("Nhà hàng nổi bật"),
    "total": MessageLookupByLibrary.simpleMessage("Tổng cộng"),
    "trackDelivery": MessageLookupByLibrary.simpleMessage("Theo dõi giao hàng"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Thử Lại"),
    "unavailable": MessageLookupByLibrary.simpleMessage("Không có sẵn"),
    "unexpectedError": MessageLookupByLibrary.simpleMessage(
      "Đã xảy ra lỗi không xác định",
    ),
    "update": MessageLookupByLibrary.simpleMessage("Cập nhật"),
    "viewAll": MessageLookupByLibrary.simpleMessage("Xem Tất Cả"),
    "vnpayPaymentTitle": MessageLookupByLibrary.simpleMessage(
      "Thanh toán VNPay",
    ),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("Chào mừng trở lại"),
    "yesBtn": MessageLookupByLibrary.simpleMessage("Có"),
    "yourCartIsEmpty": MessageLookupByLibrary.simpleMessage(
      "Giỏ hàng của bạn trống",
    ),
    "yourCourier": MessageLookupByLibrary.simpleMessage("TÀI XẾ CỦA BẠN"),
    "yourOrders": MessageLookupByLibrary.simpleMessage("Đơn Hàng Của Bạn"),
  };
}
