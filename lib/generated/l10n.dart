// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Delivery App`
  String get appTitle {
    return Intl.message('Delivery App', name: 'appTitle', desc: '', args: []);
  }

  /// `Hello World`
  String get helloWorld {
    return Intl.message('Hello World', name: 'helloWorld', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `test`
  String get test {
    return Intl.message('test', name: 'test', desc: '', args: []);
  }

  /// `test2`
  String get test2 {
    return Intl.message('test2', name: 'test2', desc: '', args: []);
  }

  /// `test3`
  String get test3 {
    return Intl.message('test3', name: 'test3', desc: '', args: []);
  }

  /// `DeliverFood`
  String get deliverFood {
    return Intl.message('DeliverFood', name: 'deliverFood', desc: '', args: []);
  }

  /// `Shopping Cart`
  String get shoppingCart {
    return Intl.message(
      'Shopping Cart',
      name: 'shoppingCart',
      desc: '',
      args: [],
    );
  }

  /// `Clear Cart`
  String get clearCart {
    return Intl.message('Clear Cart', name: 'clearCart', desc: '', args: []);
  }

  /// `Items from {restaurantName}`
  String itemsFrom(String restaurantName) {
    return Intl.message(
      'Items from $restaurantName',
      name: 'itemsFrom',
      desc: '',
      args: [restaurantName],
    );
  }

  /// `Clear Cart`
  String get clearCartTitle {
    return Intl.message(
      'Clear Cart',
      name: 'clearCartTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to remove all items from your cart?`
  String get clearCartMessage {
    return Intl.message(
      'Are you sure you want to remove all items from your cart?',
      name: 'clearCartMessage',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Clear`
  String get clear {
    return Intl.message('Clear', name: 'clear', desc: '', args: []);
  }

  /// `Your cart is empty`
  String get yourCartIsEmpty {
    return Intl.message(
      'Your cart is empty',
      name: 'yourCartIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Add some delicious items to get started`
  String get addSomeDeliciousItems {
    return Intl.message(
      'Add some delicious items to get started',
      name: 'addSomeDeliciousItems',
      desc: '',
      args: [],
    );
  }

  /// `Browse Restaurants`
  String get browseRestaurants {
    return Intl.message(
      'Browse Restaurants',
      name: 'browseRestaurants',
      desc: '',
      args: [],
    );
  }

  /// `Hide Order Details`
  String get hideOrderDetails {
    return Intl.message(
      'Hide Order Details',
      name: 'hideOrderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Show Order Details`
  String get showOrderDetails {
    return Intl.message(
      'Show Order Details',
      name: 'showOrderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Order Summary`
  String get orderSummary {
    return Intl.message(
      'Order Summary',
      name: 'orderSummary',
      desc: '',
      args: [],
    );
  }

  /// `{count} items`
  String items(int count) {
    return Intl.message('$count items', name: 'items', desc: '', args: [count]);
  }

  /// `Subtotal`
  String get subtotal {
    return Intl.message('Subtotal', name: 'subtotal', desc: '', args: []);
  }

  /// `Delivery Fee`
  String get deliveryFee {
    return Intl.message(
      'Delivery Fee',
      name: 'deliveryFee',
      desc: '',
      args: [],
    );
  }

  /// `Service Fee`
  String get serviceFee {
    return Intl.message('Service Fee', name: 'serviceFee', desc: '', args: []);
  }

  /// `Tax`
  String get tax {
    return Intl.message('Tax', name: 'tax', desc: '', args: []);
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Proceed to Checkout`
  String get proceedToCheckout {
    return Intl.message(
      'Proceed to Checkout',
      name: 'proceedToCheckout',
      desc: '',
      args: [],
    );
  }

  /// `Search restaurants`
  String get searchRestaurants {
    return Intl.message(
      'Search restaurants',
      name: 'searchRestaurants',
      desc: '',
      args: [],
    );
  }

  /// `Featured Restaurants`
  String get featuredRestaurants {
    return Intl.message(
      'Featured Restaurants',
      name: 'featuredRestaurants',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get viewAll {
    return Intl.message('View All', name: 'viewAll', desc: '', args: []);
  }

  /// `Popular Near You`
  String get popularNearYou {
    return Intl.message(
      'Popular Near You',
      name: 'popularNearYou',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
  }

  /// `Fast Food`
  String get fastFood {
    return Intl.message('Fast Food', name: 'fastFood', desc: '', args: []);
  }

  /// `Pizza`
  String get pizza {
    return Intl.message('Pizza', name: 'pizza', desc: '', args: []);
  }

  /// `Chinese`
  String get chinese {
    return Intl.message('Chinese', name: 'chinese', desc: '', args: []);
  }

  /// `Italian`
  String get italian {
    return Intl.message('Italian', name: 'italian', desc: '', args: []);
  }

  /// `Mexican`
  String get mexican {
    return Intl.message('Mexican', name: 'mexican', desc: '', args: []);
  }

  /// `Japanese`
  String get japanese {
    return Intl.message('Japanese', name: 'japanese', desc: '', args: []);
  }

  /// `Indian`
  String get indian {
    return Intl.message('Indian', name: 'indian', desc: '', args: []);
  }

  /// `Thai`
  String get thai {
    return Intl.message('Thai', name: 'thai', desc: '', args: []);
  }

  /// `Add to Cart`
  String get addToCart {
    return Intl.message('Add to Cart', name: 'addToCart', desc: '', args: []);
  }

  /// `${price}`
  String price(String price) {
    return Intl.message('\$$price', name: 'price', desc: '', args: [price]);
  }

  /// `min`
  String get min {
    return Intl.message('min', name: 'min', desc: '', args: []);
  }

  /// `{rating}`
  String rating(double rating) {
    final NumberFormat ratingNumberFormat = NumberFormat.decimalPattern(
      Intl.getCurrentLocale(),
    );
    final String ratingString = ratingNumberFormat.format(rating);

    return Intl.message(
      '$ratingString',
      name: 'rating',
      desc: '',
      args: [ratingString],
    );
  }

  /// `Free Delivery`
  String get freeDelivery {
    return Intl.message(
      'Free Delivery',
      name: 'freeDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menu {
    return Intl.message('Menu', name: 'menu', desc: '', args: []);
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `Reviews`
  String get reviews {
    return Intl.message('Reviews', name: 'reviews', desc: '', args: []);
  }

  /// `Order History`
  String get orderHistory {
    return Intl.message(
      'Order History',
      name: 'orderHistory',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Help`
  String get help {
    return Intl.message('Help', name: 'help', desc: '', args: []);
  }

  /// `Sign Out`
  String get signOut {
    return Intl.message('Sign Out', name: 'signOut', desc: '', args: []);
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message('Try Again', name: 'tryAgain', desc: '', args: []);
  }

  /// `No items found`
  String get noItemsFound {
    return Intl.message(
      'No items found',
      name: 'noItemsFound',
      desc: '',
      args: [],
    );
  }

  /// `Search for dishes...`
  String get searchHint {
    return Intl.message(
      'Search for dishes...',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  /// `Qty`
  String get quantity {
    return Intl.message('Qty', name: 'quantity', desc: '', args: []);
  }

  /// `Remove`
  String get remove {
    return Intl.message('Remove', name: 'remove', desc: '', args: []);
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Continue Shopping`
  String get continueShopping {
    return Intl.message(
      'Continue Shopping',
      name: 'continueShopping',
      desc: '',
      args: [],
    );
  }

  /// `Your Orders`
  String get yourOrders {
    return Intl.message('Your Orders', name: 'yourOrders', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Restaurants`
  String get restaurants {
    return Intl.message('Restaurants', name: 'restaurants', desc: '', args: []);
  }

  /// `Orders`
  String get orders {
    return Intl.message('Orders', name: 'orders', desc: '', args: []);
  }

  /// `Account`
  String get account {
    return Intl.message('Account', name: 'account', desc: '', args: []);
  }

  /// `Cart`
  String get cart {
    return Intl.message('Cart', name: 'cart', desc: '', args: []);
  }

  /// `Cannot add item`
  String get cannotAddItem {
    return Intl.message(
      'Cannot add item',
      name: 'cannotAddItem',
      desc: '',
      args: [],
    );
  }

  /// `You already have items from another restaurant in your cart. Please clear your current cart to add items from this restaurant.`
  String get differentRestaurantError {
    return Intl.message(
      'You already have items from another restaurant in your cart. Please clear your current cart to add items from this restaurant.',
      name: 'differentRestaurantError',
      desc: '',
      args: [],
    );
  }

  /// `Clear Current Cart`
  String get clearCurrentCart {
    return Intl.message(
      'Clear Current Cart',
      name: 'clearCurrentCart',
      desc: '',
      args: [],
    );
  }

  /// `Out of Stock`
  String get outOfStock {
    return Intl.message('Out of Stock', name: 'outOfStock', desc: '', args: []);
  }

  /// `Unavailable`
  String get unavailable {
    return Intl.message('Unavailable', name: 'unavailable', desc: '', args: []);
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Pending`
  String get pending {
    return Intl.message('Pending', name: 'pending', desc: '', args: []);
  }

  /// `Confirmed`
  String get confirmed {
    return Intl.message('Confirmed', name: 'confirmed', desc: '', args: []);
  }

  /// `Preparing`
  String get preparing {
    return Intl.message('Preparing', name: 'preparing', desc: '', args: []);
  }

  /// `Delivering`
  String get delivering {
    return Intl.message('Delivering', name: 'delivering', desc: '', args: []);
  }

  /// `Delivered`
  String get delivered {
    return Intl.message('Delivered', name: 'delivered', desc: '', args: []);
  }

  /// `Cancelled`
  String get cancelled {
    return Intl.message('Cancelled', name: 'cancelled', desc: '', args: []);
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `No Orders`
  String get noOrders {
    return Intl.message('No Orders', name: 'noOrders', desc: '', args: []);
  }

  /// `You haven't placed any orders yet. Start exploring restaurants and place your first order!`
  String get noOrdersMessage {
    return Intl.message(
      'You haven\'t placed any orders yet. Start exploring restaurants and place your first order!',
      name: 'noOrdersMessage',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Order`
  String get cancelOrder {
    return Intl.message(
      'Cancel Order',
      name: 'cancelOrder',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel this order?`
  String get cancelOrderConfirm {
    return Intl.message(
      'Are you sure you want to cancel this order?',
      name: 'cancelOrderConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Order cancelled successfully`
  String get orderCancelled {
    return Intl.message(
      'Order cancelled successfully',
      name: 'orderCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Failed to cancel order`
  String get cancelOrderFailed {
    return Intl.message(
      'Failed to cancel order',
      name: 'cancelOrderFailed',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message('Order', name: 'order', desc: '', args: []);
  }

  /// `Estimated delivery`
  String get estimatedDelivery {
    return Intl.message(
      'Estimated delivery',
      name: 'estimatedDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Featured Restaurants`
  String get top_restaurants {
    return Intl.message(
      'Featured Restaurants',
      name: 'top_restaurants',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get editAddress {
    return Intl.message('Edit', name: 'editAddress', desc: '', args: []);
  }

  /// `Set as Default`
  String get setAsDefault {
    return Intl.message(
      'Set as Default',
      name: 'setAsDefault',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Delete`
  String get confirmDeleteAddress {
    return Intl.message(
      'Confirm Delete',
      name: 'confirmDeleteAddress',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete address "{addressLabel}"?`
  String confirmDeleteAddressMessage(String addressLabel) {
    return Intl.message(
      'Are you sure you want to delete address "$addressLabel"?',
      name: 'confirmDeleteAddressMessage',
      desc: '',
      args: [addressLabel],
    );
  }

  /// `Cancel`
  String get cancelDelete {
    return Intl.message('Cancel', name: 'cancelDelete', desc: '', args: []);
  }

  /// `Delete`
  String get confirmDeleteAddressBtn {
    return Intl.message(
      'Delete',
      name: 'confirmDeleteAddressBtn',
      desc: '',
      args: [],
    );
  }

  /// `Set as default address`
  String get setAsDefaultTitle {
    return Intl.message(
      'Set as default address',
      name: 'setAsDefaultTitle',
      desc: '',
      args: [],
    );
  }

  /// `This address will be automatically selected when ordering`
  String get setAsDefaultSubtitle {
    return Intl.message(
      'This address will be automatically selected when ordering',
      name: 'setAsDefaultSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Address fetched from current location`
  String get fetchLocationSuccess {
    return Intl.message(
      'Address fetched from current location',
      name: 'fetchLocationSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Coordinates`
  String get coordinates {
    return Intl.message('Coordinates', name: 'coordinates', desc: '', args: []);
  }

  /// `Cannot fetch location`
  String get fetchLocationError {
    return Intl.message(
      'Cannot fetch location',
      name: 'fetchLocationError',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get errorPrefix {
    return Intl.message('Error', name: 'errorPrefix', desc: '', args: []);
  }

  /// `My Addresses`
  String get myAddresses {
    return Intl.message(
      'My Addresses',
      name: 'myAddresses',
      desc: '',
      args: [],
    );
  }

  /// `Add Address`
  String get addAddress {
    return Intl.message('Add Address', name: 'addAddress', desc: '', args: []);
  }

  /// `No address found`
  String get noAddressFound {
    return Intl.message(
      'No address found',
      name: 'noAddressFound',
      desc: '',
      args: [],
    );
  }

  /// `Add a delivery address to order faster`
  String get noAddressFoundSubtitle {
    return Intl.message(
      'Add a delivery address to order faster',
      name: 'noAddressFoundSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Add first address`
  String get addFirstAddress {
    return Intl.message(
      'Add first address',
      name: 'addFirstAddress',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Order`
  String get cancelOrderBtn {
    return Intl.message(
      'Cancel Order',
      name: 'cancelOrderBtn',
      desc: '',
      args: [],
    );
  }

  /// `Rate Shipper`
  String get rateShipperBtn {
    return Intl.message(
      'Rate Shipper',
      name: 'rateShipperBtn',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Order Cancellation`
  String get confirmCancelOrderTitle {
    return Intl.message(
      'Confirm Order Cancellation',
      name: 'confirmCancelOrderTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel this order?\n\nThis action cannot be undone.`
  String get confirmCancelOrderSubtitle {
    return Intl.message(
      'Are you sure you want to cancel this order?\n\nThis action cannot be undone.',
      name: 'confirmCancelOrderSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get noBtn {
    return Intl.message('No', name: 'noBtn', desc: '', args: []);
  }

  /// `Cancel Order`
  String get cancelOrderActionBtn {
    return Intl.message(
      'Cancel Order',
      name: 'cancelOrderActionBtn',
      desc: '',
      args: [],
    );
  }

  /// `Order cancelled successfully`
  String get cancelOrderSuccess {
    return Intl.message(
      'Order cancelled successfully',
      name: 'cancelOrderSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Error cancelling order`
  String get cancelOrderError {
    return Intl.message(
      'Error cancelling order',
      name: 'cancelOrderError',
      desc: '',
      args: [],
    );
  }

  /// `Go Back`
  String get goBackBtn {
    return Intl.message('Go Back', name: 'goBackBtn', desc: '', args: []);
  }

  /// `Thank you for your rating!`
  String get thanksForRating {
    return Intl.message(
      'Thank you for your rating!',
      name: 'thanksForRating',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred`
  String get ratingError {
    return Intl.message(
      'An error occurred',
      name: 'ratingError',
      desc: '',
      args: [],
    );
  }

  /// `Rate Shipper`
  String get rateShipperTitle {
    return Intl.message(
      'Rate Shipper',
      name: 'rateShipperTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your comment (optional)`
  String get ratingHint {
    return Intl.message(
      'Your comment (optional)',
      name: 'ratingHint',
      desc: '',
      args: [],
    );
  }

  /// `Submit Rating`
  String get submitRatingBtn {
    return Intl.message(
      'Submit Rating',
      name: 'submitRatingBtn',
      desc: '',
      args: [],
    );
  }

  /// `End`
  String get endBtn {
    return Intl.message('End', name: 'endBtn', desc: '', args: []);
  }

  /// `Conversation ended`
  String get conversationEnded {
    return Intl.message(
      'Conversation ended',
      name: 'conversationEnded',
      desc: '',
      args: [],
    );
  }

  /// `New conversation started`
  String get newConversationStarted {
    return Intl.message(
      'New conversation started',
      name: 'newConversationStarted',
      desc: '',
      args: [],
    );
  }

  /// `End Conversation`
  String get endConversationBtn {
    return Intl.message(
      'End Conversation',
      name: 'endConversationBtn',
      desc: '',
      args: [],
    );
  }

  /// `Start New Conversation`
  String get startNewConversationBtn {
    return Intl.message(
      'Start New Conversation',
      name: 'startNewConversationBtn',
      desc: '',
      args: [],
    );
  }

  /// `Items out of stock`
  String get outOfStockItems {
    return Intl.message(
      'Items out of stock',
      name: 'outOfStockItems',
      desc: '',
      args: [],
    );
  }

  /// `Got it`
  String get gotItBtn {
    return Intl.message('Got it', name: 'gotItBtn', desc: '', args: []);
  }

  /// `Please select a delivery address`
  String get pleaseSelectAddress {
    return Intl.message(
      'Please select a delivery address',
      name: 'pleaseSelectAddress',
      desc: '',
      args: [],
    );
  }

  /// `VNPay Payment`
  String get vnpayPaymentTitle {
    return Intl.message(
      'VNPay Payment',
      name: 'vnpayPaymentTitle',
      desc: '',
      args: [],
    );
  }

  /// `Cancel payment?`
  String get cancelPaymentWarningTitle {
    return Intl.message(
      'Cancel payment?',
      name: 'cancelPaymentWarningTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel the payment process?`
  String get cancelPaymentWarningSubtitle {
    return Intl.message(
      'Are you sure you want to cancel the payment process?',
      name: 'cancelPaymentWarningSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yesBtn {
    return Intl.message('Yes', name: 'yesBtn', desc: '', args: []);
  }

  /// `Added {productName} to cart`
  String addedToCartLivestream(String productName) {
    return Intl.message(
      'Added $productName to cart',
      name: 'addedToCartLivestream',
      desc: '',
      args: [productName],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
