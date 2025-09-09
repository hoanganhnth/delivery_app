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

  static String m0(count) => "${count} items";

  static String m1(restaurantName) => "Items from ${restaurantName}";

  static String m2(price) => "\$${price}";

  static String m3(rating) => "${rating}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("About"),
    "account": MessageLookupByLibrary.simpleMessage("Account"),
    "addSomeDeliciousItems": MessageLookupByLibrary.simpleMessage(
      "Add some delicious items to get started",
    ),
    "addToCart": MessageLookupByLibrary.simpleMessage("Add to Cart"),
    "all": MessageLookupByLibrary.simpleMessage("All"),
    "appTitle": MessageLookupByLibrary.simpleMessage("Delivery App"),
    "browseRestaurants": MessageLookupByLibrary.simpleMessage(
      "Browse Restaurants",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelOrder": MessageLookupByLibrary.simpleMessage("Cancel Order"),
    "cancelOrderConfirm": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to cancel this order?",
    ),
    "cancelOrderFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to cancel order",
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
    "confirmed": MessageLookupByLibrary.simpleMessage("Confirmed"),
    "continueShopping": MessageLookupByLibrary.simpleMessage(
      "Continue Shopping",
    ),
    "deliverFood": MessageLookupByLibrary.simpleMessage("DeliverFood"),
    "delivered": MessageLookupByLibrary.simpleMessage("Delivered"),
    "delivering": MessageLookupByLibrary.simpleMessage("Delivering"),
    "deliveryFee": MessageLookupByLibrary.simpleMessage("Delivery Fee"),
    "differentRestaurantError": MessageLookupByLibrary.simpleMessage(
      "You already have items from another restaurant in your cart. Please clear your current cart to add items from this restaurant.",
    ),
    "error": MessageLookupByLibrary.simpleMessage("Error"),
    "estimatedDelivery": MessageLookupByLibrary.simpleMessage(
      "Estimated delivery",
    ),
    "fastFood": MessageLookupByLibrary.simpleMessage("Fast Food"),
    "featuredRestaurants": MessageLookupByLibrary.simpleMessage(
      "Featured Restaurants",
    ),
    "freeDelivery": MessageLookupByLibrary.simpleMessage("Free Delivery"),
    "helloWorld": MessageLookupByLibrary.simpleMessage("Hello World"),
    "help": MessageLookupByLibrary.simpleMessage("Help"),
    "hideOrderDetails": MessageLookupByLibrary.simpleMessage(
      "Hide Order Details",
    ),
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "indian": MessageLookupByLibrary.simpleMessage("Indian"),
    "italian": MessageLookupByLibrary.simpleMessage("Italian"),
    "items": m0,
    "itemsFrom": m1,
    "japanese": MessageLookupByLibrary.simpleMessage("Japanese"),
    "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "menu": MessageLookupByLibrary.simpleMessage("Menu"),
    "mexican": MessageLookupByLibrary.simpleMessage("Mexican"),
    "min": MessageLookupByLibrary.simpleMessage("min"),
    "noItemsFound": MessageLookupByLibrary.simpleMessage("No items found"),
    "noOrders": MessageLookupByLibrary.simpleMessage("No Orders"),
    "noOrdersMessage": MessageLookupByLibrary.simpleMessage(
      "You haven\'t placed any orders yet. Start exploring restaurants and place your first order!",
    ),
    "order": MessageLookupByLibrary.simpleMessage("Order"),
    "orderCancelled": MessageLookupByLibrary.simpleMessage(
      "Order cancelled successfully",
    ),
    "orderHistory": MessageLookupByLibrary.simpleMessage("Order History"),
    "orderSummary": MessageLookupByLibrary.simpleMessage("Order Summary"),
    "orders": MessageLookupByLibrary.simpleMessage("Orders"),
    "outOfStock": MessageLookupByLibrary.simpleMessage("Out of Stock"),
    "pending": MessageLookupByLibrary.simpleMessage("Pending"),
    "pizza": MessageLookupByLibrary.simpleMessage("Pizza"),
    "popularNearYou": MessageLookupByLibrary.simpleMessage("Popular Near You"),
    "preparing": MessageLookupByLibrary.simpleMessage("Preparing"),
    "price": m2,
    "proceedToCheckout": MessageLookupByLibrary.simpleMessage(
      "Proceed to Checkout",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "quantity": MessageLookupByLibrary.simpleMessage("Qty"),
    "rating": m3,
    "remove": MessageLookupByLibrary.simpleMessage("Remove"),
    "restaurants": MessageLookupByLibrary.simpleMessage("Restaurants"),
    "retry": MessageLookupByLibrary.simpleMessage("Retry"),
    "reviews": MessageLookupByLibrary.simpleMessage("Reviews"),
    "searchHint": MessageLookupByLibrary.simpleMessage("Search for dishes..."),
    "searchRestaurants": MessageLookupByLibrary.simpleMessage(
      "Search restaurants",
    ),
    "serviceFee": MessageLookupByLibrary.simpleMessage("Service Fee"),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "shoppingCart": MessageLookupByLibrary.simpleMessage("Shopping Cart"),
    "showOrderDetails": MessageLookupByLibrary.simpleMessage(
      "Show Order Details",
    ),
    "signOut": MessageLookupByLibrary.simpleMessage("Sign Out"),
    "subtotal": MessageLookupByLibrary.simpleMessage("Subtotal"),
    "tax": MessageLookupByLibrary.simpleMessage("Tax"),
    "test": MessageLookupByLibrary.simpleMessage("test"),
    "test2": MessageLookupByLibrary.simpleMessage("test2"),
    "test3": MessageLookupByLibrary.simpleMessage("test3"),
    "thai": MessageLookupByLibrary.simpleMessage("Thai"),
    "total": MessageLookupByLibrary.simpleMessage("Total"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Try Again"),
    "unavailable": MessageLookupByLibrary.simpleMessage("Unavailable"),
    "update": MessageLookupByLibrary.simpleMessage("Update"),
    "viewAll": MessageLookupByLibrary.simpleMessage("View All"),
    "yourCartIsEmpty": MessageLookupByLibrary.simpleMessage(
      "Your cart is empty",
    ),
    "yourOrders": MessageLookupByLibrary.simpleMessage("Your Orders"),
  };
}
