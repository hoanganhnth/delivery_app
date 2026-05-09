// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(productName) => "Added ${productName} to cart";

  static String m1(addressLabel) =>
      "Are you sure you want to delete address \"${addressLabel}\"?";

  static String m2(count) => "${count} items";

  static String m3(restaurantName) => "Items from ${restaurantName}";

  static String m4(price) => "\$${price}";

  static String m5(rating) => "${rating}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("About"),
    "account": MessageLookupByLibrary.simpleMessage("Account"),
    "addAddress": MessageLookupByLibrary.simpleMessage("Add Address"),
    "addFirstAddress": MessageLookupByLibrary.simpleMessage(
      "Add first address",
    ),
    "addSomeDeliciousItems": MessageLookupByLibrary.simpleMessage(
      "Add some delicious items to get started",
    ),
    "addToCart": MessageLookupByLibrary.simpleMessage("Add to Cart"),
    "addedToCartLivestream": m0,
    "addressAdd": MessageLookupByLibrary.simpleMessage("Add Address"),
    "addressAddTitle": MessageLookupByLibrary.simpleMessage("Add New Address"),
    "addressAutoFillLocation": MessageLookupByLibrary.simpleMessage(
      "Auto fill from GPS",
    ),
    "addressCity": MessageLookupByLibrary.simpleMessage("City/Province"),
    "addressCityHint": MessageLookupByLibrary.simpleMessage(
      "Enter city/province",
    ),
    "addressDelete": MessageLookupByLibrary.simpleMessage("Delete"),
    "addressDetails": MessageLookupByLibrary.simpleMessage("Address Details"),
    "addressDistrict": MessageLookupByLibrary.simpleMessage("District"),
    "addressDistrictHint": MessageLookupByLibrary.simpleMessage(
      "Enter district",
    ),
    "addressEditTitle": MessageLookupByLibrary.simpleMessage("Edit Address"),
    "addressGetCurrentLocation": MessageLookupByLibrary.simpleMessage(
      "Get Current Location",
    ),
    "addressGettingLocation": MessageLookupByLibrary.simpleMessage(
      "Getting location...",
    ),
    "addressHome": MessageLookupByLibrary.simpleMessage("Home"),
    "addressInfo": MessageLookupByLibrary.simpleMessage("Address Info"),
    "addressLabel": MessageLookupByLibrary.simpleMessage("Address Label"),
    "addressLabelHint": MessageLookupByLibrary.simpleMessage(
      "e.g., Home, Work...",
    ),
    "addressLabelRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter address label",
    ),
    "addressLine": MessageLookupByLibrary.simpleMessage("Detailed Address"),
    "addressLineHint": MessageLookupByLibrary.simpleMessage(
      "House number, street name...",
    ),
    "addressLineRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter detailed address",
    ),
    "addressOther": MessageLookupByLibrary.simpleMessage("Other"),
    "addressPhone": MessageLookupByLibrary.simpleMessage("Phone Number"),
    "addressPhoneHint": MessageLookupByLibrary.simpleMessage(
      "Enter phone number",
    ),
    "addressPhoneInvalid": MessageLookupByLibrary.simpleMessage(
      "Invalid phone number",
    ),
    "addressPhoneRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter phone number",
    ),
    "addressPostalCode": MessageLookupByLibrary.simpleMessage("Postal Code"),
    "addressPostalCodeHint": MessageLookupByLibrary.simpleMessage("Optional"),
    "addressRecipientHint": MessageLookupByLibrary.simpleMessage(
      "Enter recipient name",
    ),
    "addressRecipientName": MessageLookupByLibrary.simpleMessage(
      "Recipient Name",
    ),
    "addressRecipientRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter recipient name",
    ),
    "addressRequiredField": MessageLookupByLibrary.simpleMessage("Required"),
    "addressSave": MessageLookupByLibrary.simpleMessage("Save Changes"),
    "addressSchool": MessageLookupByLibrary.simpleMessage("School"),
    "addressType": MessageLookupByLibrary.simpleMessage("Address Type"),
    "addressWard": MessageLookupByLibrary.simpleMessage("Ward/Commune"),
    "addressWardHint": MessageLookupByLibrary.simpleMessage(
      "Enter ward/commune",
    ),
    "addressWork": MessageLookupByLibrary.simpleMessage("Work"),
    "all": MessageLookupByLibrary.simpleMessage("All"),
    "alreadyHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Already have an account? ",
    ),
    "anonymous": MessageLookupByLibrary.simpleMessage("Anonymous"),
    "appTitle": MessageLookupByLibrary.simpleMessage("Delivery App"),
    "backToLogin": MessageLookupByLibrary.simpleMessage("Back to Login"),
    "browseRestaurants": MessageLookupByLibrary.simpleMessage(
      "Browse Restaurants",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelDelete": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelOrder": MessageLookupByLibrary.simpleMessage("Cancel Order"),
    "cancelOrderActionBtn": MessageLookupByLibrary.simpleMessage(
      "Cancel Order",
    ),
    "cancelOrderBtn": MessageLookupByLibrary.simpleMessage("Cancel Order"),
    "cancelOrderConfirm": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to cancel this order?",
    ),
    "cancelOrderError": MessageLookupByLibrary.simpleMessage(
      "Error cancelling order",
    ),
    "cancelOrderFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to cancel order",
    ),
    "cancelOrderSuccess": MessageLookupByLibrary.simpleMessage(
      "Order cancelled successfully",
    ),
    "cancelPaymentWarningSubtitle": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to cancel the payment process?",
    ),
    "cancelPaymentWarningTitle": MessageLookupByLibrary.simpleMessage(
      "Cancel payment?",
    ),
    "cancelled": MessageLookupByLibrary.simpleMessage("Cancelled"),
    "cannotAddItem": MessageLookupByLibrary.simpleMessage("Cannot add item"),
    "cart": MessageLookupByLibrary.simpleMessage("Cart"),
    "categories": MessageLookupByLibrary.simpleMessage("Categories"),
    "chinese": MessageLookupByLibrary.simpleMessage("Chinese"),
    "clear": MessageLookupByLibrary.simpleMessage("Clear"),
    "clearCart": MessageLookupByLibrary.simpleMessage("Clear Cart"),
    "clearCartMessage": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to remove all items from your cart?",
    ),
    "clearCartTitle": MessageLookupByLibrary.simpleMessage("Clear Cart"),
    "clearCurrentCart": MessageLookupByLibrary.simpleMessage(
      "Clear Current Cart",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmCancelOrderSubtitle": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to cancel this order?\n\nThis action cannot be undone.",
    ),
    "confirmCancelOrderTitle": MessageLookupByLibrary.simpleMessage(
      "Confirm Order Cancellation",
    ),
    "confirmDeleteAddress": MessageLookupByLibrary.simpleMessage(
      "Confirm Delete",
    ),
    "confirmDeleteAddressBtn": MessageLookupByLibrary.simpleMessage("Delete"),
    "confirmDeleteAddressMessage": m1,
    "confirmPassword": MessageLookupByLibrary.simpleMessage("CONFIRM PASSWORD"),
    "confirmYourPassword": MessageLookupByLibrary.simpleMessage(
      "Please confirm your password",
    ),
    "confirmed": MessageLookupByLibrary.simpleMessage("Confirmed"),
    "connected": MessageLookupByLibrary.simpleMessage("Connected"),
    "connecting": MessageLookupByLibrary.simpleMessage("Connecting..."),
    "continueShopping": MessageLookupByLibrary.simpleMessage(
      "Continue Shopping",
    ),
    "conversationEnded": MessageLookupByLibrary.simpleMessage(
      "Conversation ended",
    ),
    "coordinates": MessageLookupByLibrary.simpleMessage("Coordinates"),
    "createAccount": MessageLookupByLibrary.simpleMessage("Create Account"),
    "createAccountBtn": MessageLookupByLibrary.simpleMessage("CREATE ACCOUNT"),
    "deliverFood": MessageLookupByLibrary.simpleMessage("DeliverFood"),
    "delivered": MessageLookupByLibrary.simpleMessage("Delivered"),
    "deliveredSuccess": MessageLookupByLibrary.simpleMessage(
      "Delivery Successful!",
    ),
    "deliveredSuccessMessage": MessageLookupByLibrary.simpleMessage(
      "Your order has been delivered to your destination.",
    ),
    "delivering": MessageLookupByLibrary.simpleMessage("Delivering"),
    "deliveryFee": MessageLookupByLibrary.simpleMessage("Delivery Fee"),
    "differentRestaurantError": MessageLookupByLibrary.simpleMessage(
      "You already have items from another restaurant in your cart. Please clear your current cart to add items from this restaurant.",
    ),
    "disconnected": MessageLookupByLibrary.simpleMessage("Disconnected"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account? ",
    ),
    "editAddress": MessageLookupByLibrary.simpleMessage("Edit"),
    "emailAddress": MessageLookupByLibrary.simpleMessage("EMAIL ADDRESS"),
    "emailHint": MessageLookupByLibrary.simpleMessage("chef@amberhearth.com"),
    "endBtn": MessageLookupByLibrary.simpleMessage("End"),
    "endConversationBtn": MessageLookupByLibrary.simpleMessage(
      "End Conversation",
    ),
    "enterEmail": MessageLookupByLibrary.simpleMessage(
      "Please enter your email",
    ),
    "enterPassword": MessageLookupByLibrary.simpleMessage(
      "Please enter your password",
    ),
    "error": MessageLookupByLibrary.simpleMessage("Error"),
    "errorPrefix": MessageLookupByLibrary.simpleMessage("Error"),
    "estimatedDelivery": MessageLookupByLibrary.simpleMessage(
      "Estimated delivery",
    ),
    "fastFood": MessageLookupByLibrary.simpleMessage("Fast Food"),
    "featuredRestaurants": MessageLookupByLibrary.simpleMessage(
      "Featured Restaurants",
    ),
    "fetchLocationError": MessageLookupByLibrary.simpleMessage(
      "Cannot fetch location",
    ),
    "fetchLocationSuccess": MessageLookupByLibrary.simpleMessage(
      "Address fetched from current location",
    ),
    "findingDriver": MessageLookupByLibrary.simpleMessage(
      "Finding Delivery Driver",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Forgot Password?"),
    "freeDelivery": MessageLookupByLibrary.simpleMessage("Free Delivery"),
    "fullName": MessageLookupByLibrary.simpleMessage("FULL NAME"),
    "fullNameHint": MessageLookupByLibrary.simpleMessage("Johnathan Doe"),
    "goBackBtn": MessageLookupByLibrary.simpleMessage("Go Back"),
    "gotItBtn": MessageLookupByLibrary.simpleMessage("Got it"),
    "helloWorld": MessageLookupByLibrary.simpleMessage("Hello World"),
    "help": MessageLookupByLibrary.simpleMessage("Help"),
    "hideOrderDetails": MessageLookupByLibrary.simpleMessage(
      "Hide Order Details",
    ),
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "indian": MessageLookupByLibrary.simpleMessage("Indian"),
    "invalidEmail": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid email",
    ),
    "italian": MessageLookupByLibrary.simpleMessage("Italian"),
    "items": m2,
    "itemsFrom": m3,
    "japanese": MessageLookupByLibrary.simpleMessage("Japanese"),
    "joinTheHearth": MessageLookupByLibrary.simpleMessage("JOIN THE HEARTH"),
    "livestreamEnded": MessageLookupByLibrary.simpleMessage(
      "Livestream has ended",
    ),
    "livestreamOngoing": MessageLookupByLibrary.simpleMessage(
      "Ongoing Livestream",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "loginSubtitle": MessageLookupByLibrary.simpleMessage(
      "Savor the moment. Sign in to your kitchen.",
    ),
    "loginSuccess": MessageLookupByLibrary.simpleMessage("Login successful!"),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "mapWillShowWhenDriverAccepts": MessageLookupByLibrary.simpleMessage(
      "Map will appear when a driver accepts the order",
    ),
    "menu": MessageLookupByLibrary.simpleMessage("Menu"),
    "mexican": MessageLookupByLibrary.simpleMessage("Mexican"),
    "min": MessageLookupByLibrary.simpleMessage("min"),
    "myAddresses": MessageLookupByLibrary.simpleMessage("My Addresses"),
    "newConversationStarted": MessageLookupByLibrary.simpleMessage(
      "New conversation started",
    ),
    "noAddressFound": MessageLookupByLibrary.simpleMessage("No address found"),
    "noAddressFoundSubtitle": MessageLookupByLibrary.simpleMessage(
      "Add a delivery address to order faster",
    ),
    "noBtn": MessageLookupByLibrary.simpleMessage("No"),
    "noItemsFound": MessageLookupByLibrary.simpleMessage("No items found"),
    "noOrders": MessageLookupByLibrary.simpleMessage("No Orders"),
    "noOrdersMessage": MessageLookupByLibrary.simpleMessage(
      "You haven\'t placed any orders yet. Start exploring restaurants and place your first order!",
    ),
    "noTrackingInfo": MessageLookupByLibrary.simpleMessage(
      "No Tracking Information",
    ),
    "order": MessageLookupByLibrary.simpleMessage("Order"),
    "orderCancelled": MessageLookupByLibrary.simpleMessage(
      "Order cancelled successfully",
    ),
    "orderHistory": MessageLookupByLibrary.simpleMessage("Order History"),
    "orderSummary": MessageLookupByLibrary.simpleMessage("Order Summary"),
    "orders": MessageLookupByLibrary.simpleMessage("Orders"),
    "outOfStock": MessageLookupByLibrary.simpleMessage("Out of Stock"),
    "outOfStockItems": MessageLookupByLibrary.simpleMessage(
      "Items out of stock",
    ),
    "password": MessageLookupByLibrary.simpleMessage("PASSWORD"),
    "passwordHelper": MessageLookupByLibrary.simpleMessage(
      "Must be at least 8 characters with a mix of symbols.",
    ),
    "passwordHint": MessageLookupByLibrary.simpleMessage("••••••••"),
    "passwordMinLength": MessageLookupByLibrary.simpleMessage(
      "Password must be at least 6 characters",
    ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "paymentInfo": MessageLookupByLibrary.simpleMessage("Payment Information"),
    "paymentMethodText": MessageLookupByLibrary.simpleMessage("Payment Method"),
    "pending": MessageLookupByLibrary.simpleMessage("Pending"),
    "pinnedUppercase": MessageLookupByLibrary.simpleMessage("PINNED"),
    "pizza": MessageLookupByLibrary.simpleMessage("Pizza"),
    "pleaseSelectAddress": MessageLookupByLibrary.simpleMessage(
      "Please select a delivery address",
    ),
    "popularNearYou": MessageLookupByLibrary.simpleMessage("Popular Near You"),
    "preparing": MessageLookupByLibrary.simpleMessage("Preparing"),
    "price": m4,
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "proceedToCheckout": MessageLookupByLibrary.simpleMessage(
      "Proceed to Checkout",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "profileChangePassword": MessageLookupByLibrary.simpleMessage(
      "Change Password",
    ),
    "profileChangePasswordDesc": MessageLookupByLibrary.simpleMessage(
      "Update password regularly",
    ),
    "profileCustomerSupport": MessageLookupByLibrary.simpleMessage(
      "Customer Support",
    ),
    "profileCustomerSupportDesc": MessageLookupByLibrary.simpleMessage(
      "Chat with CS 24/7",
    ),
    "profileEditProfile": MessageLookupByLibrary.simpleMessage("Edit Profile"),
    "profileEditProfileDesc": MessageLookupByLibrary.simpleMessage(
      "Update personal info",
    ),
    "profileHelpFAQ": MessageLookupByLibrary.simpleMessage("Help & FAQ"),
    "profileHelpFAQDesc": MessageLookupByLibrary.simpleMessage(
      "Frequently asked questions",
    ),
    "profileLogout": MessageLookupByLibrary.simpleMessage("Log Out"),
    "profileMyAddresses": MessageLookupByLibrary.simpleMessage("My Addresses"),
    "profileMyAddressesDesc": MessageLookupByLibrary.simpleMessage(
      "Manage delivery addresses",
    ),
    "profilePaymentMethods": MessageLookupByLibrary.simpleMessage(
      "Payment Methods",
    ),
    "profilePaymentMethodsDesc": MessageLookupByLibrary.simpleMessage(
      "Add or remove cards",
    ),
    "profileSecurity": MessageLookupByLibrary.simpleMessage("Security"),
    "profileSupport": MessageLookupByLibrary.simpleMessage("Support"),
    "profileTermsPolicies": MessageLookupByLibrary.simpleMessage(
      "Terms & Policies",
    ),
    "profileTermsPoliciesDesc": MessageLookupByLibrary.simpleMessage(
      "Usage rules",
    ),
    "profileTitle": MessageLookupByLibrary.simpleMessage("Account"),
    "quantity": MessageLookupByLibrary.simpleMessage("Qty"),
    "rateShipperBtn": MessageLookupByLibrary.simpleMessage("Rate Shipper"),
    "rateShipperTitle": MessageLookupByLibrary.simpleMessage("Rate Shipper"),
    "rating": m5,
    "ratingError": MessageLookupByLibrary.simpleMessage("An error occurred"),
    "ratingHint": MessageLookupByLibrary.simpleMessage(
      "Your comment (optional)",
    ),
    "register": MessageLookupByLibrary.simpleMessage("Register"),
    "registerFailed": MessageLookupByLibrary.simpleMessage(
      "Registration failed. Please try again later.",
    ),
    "registerSubtitle": MessageLookupByLibrary.simpleMessage(
      "Step into a world of curated culinary experiences. Register to start your journey with Amber Hearth.",
    ),
    "registerSuccess": MessageLookupByLibrary.simpleMessage(
      "Registration successful!",
    ),
    "remove": MessageLookupByLibrary.simpleMessage("Remove"),
    "restaurants": MessageLookupByLibrary.simpleMessage("Restaurants"),
    "retry": MessageLookupByLibrary.simpleMessage("Retry"),
    "reviews": MessageLookupByLibrary.simpleMessage("Reviews"),
    "searchHint": MessageLookupByLibrary.simpleMessage("Search for dishes..."),
    "searchRestaurants": MessageLookupByLibrary.simpleMessage(
      "Search restaurants",
    ),
    "serviceFee": MessageLookupByLibrary.simpleMessage("Service Fee"),
    "setAsDefault": MessageLookupByLibrary.simpleMessage("Set as Default"),
    "setAsDefaultSubtitle": MessageLookupByLibrary.simpleMessage(
      "This address will be automatically selected when ordering",
    ),
    "setAsDefaultTitle": MessageLookupByLibrary.simpleMessage(
      "Set as default address",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "settingsAbout": MessageLookupByLibrary.simpleMessage("About"),
    "settingsAboutApp": MessageLookupByLibrary.simpleMessage("About App"),
    "settingsAboutAppDesc": MessageLookupByLibrary.simpleMessage(
      "Version 1.0.0",
    ),
    "settingsAppearance": MessageLookupByLibrary.simpleMessage("Appearance"),
    "settingsClearCache": MessageLookupByLibrary.simpleMessage("Clear Cache"),
    "settingsClearCacheDesc": MessageLookupByLibrary.simpleMessage(
      "Free up memory",
    ),
    "settingsCookieTracking": MessageLookupByLibrary.simpleMessage(
      "Cookie & Tracking",
    ),
    "settingsCookieTrackingDesc": MessageLookupByLibrary.simpleMessage(
      "Manage preferences",
    ),
    "settingsDangerZone": MessageLookupByLibrary.simpleMessage("Danger Zone"),
    "settingsDarkMode": MessageLookupByLibrary.simpleMessage("Dark Mode"),
    "settingsDarkModeDesc": MessageLookupByLibrary.simpleMessage(
      "Protect eyes at night",
    ),
    "settingsDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Delete Account",
    ),
    "settingsDeleteAccountDesc": MessageLookupByLibrary.simpleMessage(
      "Permanently delete all data",
    ),
    "settingsLanguage": MessageLookupByLibrary.simpleMessage("Language"),
    "settingsLanguageTitle": MessageLookupByLibrary.simpleMessage(
      "Choose Language",
    ),
    "settingsNotifications": MessageLookupByLibrary.simpleMessage(
      "Notifications",
    ),
    "settingsOrderUpdates": MessageLookupByLibrary.simpleMessage(
      "Order Updates",
    ),
    "settingsOrderUpdatesDesc": MessageLookupByLibrary.simpleMessage(
      "Real-time delivery status",
    ),
    "settingsPrivacy": MessageLookupByLibrary.simpleMessage("Privacy"),
    "settingsPrivacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Privacy Policy",
    ),
    "settingsPrivacyPolicyDesc": MessageLookupByLibrary.simpleMessage(
      "How we protect data",
    ),
    "settingsPromotions": MessageLookupByLibrary.simpleMessage("Promotions"),
    "settingsPromotionsDesc": MessageLookupByLibrary.simpleMessage(
      "Deals and offers",
    ),
    "settingsPushNotifications": MessageLookupByLibrary.simpleMessage(
      "Push Notifications",
    ),
    "settingsPushNotificationsDesc": MessageLookupByLibrary.simpleMessage(
      "Receive app notifications",
    ),
    "settingsRateApp": MessageLookupByLibrary.simpleMessage("Rate App"),
    "settingsRateAppDesc": MessageLookupByLibrary.simpleMessage(
      "Share your experience",
    ),
    "settingsShareApp": MessageLookupByLibrary.simpleMessage("Share App"),
    "settingsShareAppDesc": MessageLookupByLibrary.simpleMessage(
      "Refer friends",
    ),
    "settingsTermsOfUse": MessageLookupByLibrary.simpleMessage("Terms of Use"),
    "settingsTermsOfUseDesc": MessageLookupByLibrary.simpleMessage(
      "Rules and conditions",
    ),
    "settingsTitle": MessageLookupByLibrary.simpleMessage("Settings"),
    "shipperNotStarted": MessageLookupByLibrary.simpleMessage(
      "The shipper has not started delivering this order",
    ),
    "shoppingCart": MessageLookupByLibrary.simpleMessage("Shopping Cart"),
    "showOrderDetails": MessageLookupByLibrary.simpleMessage(
      "Show Order Details",
    ),
    "signIn": MessageLookupByLibrary.simpleMessage("SIGN IN"),
    "signInWithGoogle": MessageLookupByLibrary.simpleMessage(
      "Sign in with Google",
    ),
    "signOut": MessageLookupByLibrary.simpleMessage("Sign Out"),
    "startNewConversationBtn": MessageLookupByLibrary.simpleMessage(
      "Start New Conversation",
    ),
    "submitRatingBtn": MessageLookupByLibrary.simpleMessage("Submit Rating"),
    "subtotal": MessageLookupByLibrary.simpleMessage("Subtotal"),
    "tax": MessageLookupByLibrary.simpleMessage("Tax"),
    "termsAnd": MessageLookupByLibrary.simpleMessage(" and "),
    "termsDot": MessageLookupByLibrary.simpleMessage("."),
    "termsOfService": MessageLookupByLibrary.simpleMessage("Terms of Service"),
    "termsPrefix": MessageLookupByLibrary.simpleMessage(
      "By creating an account, you agree to Amber Hearth\'s ",
    ),
    "test": MessageLookupByLibrary.simpleMessage("test"),
    "test2": MessageLookupByLibrary.simpleMessage("test2"),
    "test3": MessageLookupByLibrary.simpleMessage("test3"),
    "thai": MessageLookupByLibrary.simpleMessage("Thai"),
    "thanksForRating": MessageLookupByLibrary.simpleMessage(
      "Thank you for your rating!",
    ),
    "top_restaurants": MessageLookupByLibrary.simpleMessage(
      "Featured Restaurants",
    ),
    "total": MessageLookupByLibrary.simpleMessage("Total"),
    "trackDelivery": MessageLookupByLibrary.simpleMessage("Track Delivery"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Try Again"),
    "unavailable": MessageLookupByLibrary.simpleMessage("Unavailable"),
    "unexpectedError": MessageLookupByLibrary.simpleMessage(
      "An unexpected error occurred",
    ),
    "update": MessageLookupByLibrary.simpleMessage("Update"),
    "viewAll": MessageLookupByLibrary.simpleMessage("View All"),
    "vnpayPaymentTitle": MessageLookupByLibrary.simpleMessage("VNPay Payment"),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("Welcome Back"),
    "yesBtn": MessageLookupByLibrary.simpleMessage("Yes"),
    "yourCartIsEmpty": MessageLookupByLibrary.simpleMessage(
      "Your cart is empty",
    ),
    "yourCourier": MessageLookupByLibrary.simpleMessage("YOUR COURIER"),
    "yourOrders": MessageLookupByLibrary.simpleMessage("Your Orders"),
  };
}
