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

  /// `Payment Information`
  String get paymentInfo {
    return Intl.message(
      'Payment Information',
      name: 'paymentInfo',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get paymentMethodText {
    return Intl.message(
      'Payment Method',
      name: 'paymentMethodText',
      desc: '',
      args: [],
    );
  }

  /// `Track Delivery`
  String get trackDelivery {
    return Intl.message(
      'Track Delivery',
      name: 'trackDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Connected`
  String get connected {
    return Intl.message('Connected', name: 'connected', desc: '', args: []);
  }

  /// `Disconnected`
  String get disconnected {
    return Intl.message(
      'Disconnected',
      name: 'disconnected',
      desc: '',
      args: [],
    );
  }

  /// `Connecting...`
  String get connecting {
    return Intl.message(
      'Connecting...',
      name: 'connecting',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Successful!`
  String get deliveredSuccess {
    return Intl.message(
      'Delivery Successful!',
      name: 'deliveredSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Your order has been delivered to your destination.`
  String get deliveredSuccessMessage {
    return Intl.message(
      'Your order has been delivered to your destination.',
      name: 'deliveredSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `Finding Delivery Driver`
  String get findingDriver {
    return Intl.message(
      'Finding Delivery Driver',
      name: 'findingDriver',
      desc: '',
      args: [],
    );
  }

  /// `Map will appear when a driver accepts the order`
  String get mapWillShowWhenDriverAccepts {
    return Intl.message(
      'Map will appear when a driver accepts the order',
      name: 'mapWillShowWhenDriverAccepts',
      desc: '',
      args: [],
    );
  }

  /// `No Tracking Information`
  String get noTrackingInfo {
    return Intl.message(
      'No Tracking Information',
      name: 'noTrackingInfo',
      desc: '',
      args: [],
    );
  }

  /// `The shipper has not started delivering this order`
  String get shipperNotStarted {
    return Intl.message(
      'The shipper has not started delivering this order',
      name: 'shipperNotStarted',
      desc: '',
      args: [],
    );
  }

  /// `YOUR COURIER`
  String get yourCourier {
    return Intl.message(
      'YOUR COURIER',
      name: 'yourCourier',
      desc: '',
      args: [],
    );
  }

  /// `Ongoing Livestream`
  String get livestreamOngoing {
    return Intl.message(
      'Ongoing Livestream',
      name: 'livestreamOngoing',
      desc: '',
      args: [],
    );
  }

  /// `Livestream has ended`
  String get livestreamEnded {
    return Intl.message(
      'Livestream has ended',
      name: 'livestreamEnded',
      desc: '',
      args: [],
    );
  }

  /// `Anonymous`
  String get anonymous {
    return Intl.message('Anonymous', name: 'anonymous', desc: '', args: []);
  }

  /// `PINNED`
  String get pinnedUppercase {
    return Intl.message('PINNED', name: 'pinnedUppercase', desc: '', args: []);
  }

  /// `Login successful!`
  String get loginSuccess {
    return Intl.message(
      'Login successful!',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Savor the moment. Sign in to your kitchen.`
  String get loginSubtitle {
    return Intl.message(
      'Savor the moment. Sign in to your kitchen.',
      name: 'loginSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `EMAIL ADDRESS`
  String get emailAddress {
    return Intl.message(
      'EMAIL ADDRESS',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `chef@amberhearth.com`
  String get emailHint {
    return Intl.message(
      'chef@amberhearth.com',
      name: 'emailHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get enterEmail {
    return Intl.message(
      'Please enter your email',
      name: 'enterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get invalidEmail {
    return Intl.message(
      'Please enter a valid email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `PASSWORD`
  String get password {
    return Intl.message('PASSWORD', name: 'password', desc: '', args: []);
  }

  /// `••••••••`
  String get passwordHint {
    return Intl.message('••••••••', name: 'passwordHint', desc: '', args: []);
  }

  /// `Please enter your password`
  String get enterPassword {
    return Intl.message(
      'Please enter your password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get passwordMinLength {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'passwordMinLength',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `SIGN IN`
  String get signIn {
    return Intl.message('SIGN IN', name: 'signIn', desc: '', args: []);
  }

  /// `Sign in with Google`
  String get signInWithGoogle {
    return Intl.message(
      'Sign in with Google',
      name: 'signInWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? `
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account? ',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `JOIN THE HEARTH`
  String get joinTheHearth {
    return Intl.message(
      'JOIN THE HEARTH',
      name: 'joinTheHearth',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Step into a world of curated culinary experiences. Register to start your journey with Amber Hearth.`
  String get registerSubtitle {
    return Intl.message(
      'Step into a world of curated culinary experiences. Register to start your journey with Amber Hearth.',
      name: 'registerSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `FULL NAME`
  String get fullName {
    return Intl.message('FULL NAME', name: 'fullName', desc: '', args: []);
  }

  /// `Johnathan Doe`
  String get fullNameHint {
    return Intl.message(
      'Johnathan Doe',
      name: 'fullNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Must be at least 8 characters with a mix of symbols.`
  String get passwordHelper {
    return Intl.message(
      'Must be at least 8 characters with a mix of symbols.',
      name: 'passwordHelper',
      desc: '',
      args: [],
    );
  }

  /// `CONFIRM PASSWORD`
  String get confirmPassword {
    return Intl.message(
      'CONFIRM PASSWORD',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get confirmYourPassword {
    return Intl.message(
      'Please confirm your password',
      name: 'confirmYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `CREATE ACCOUNT`
  String get createAccountBtn {
    return Intl.message(
      'CREATE ACCOUNT',
      name: 'createAccountBtn',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? `
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account? ',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Back to Login`
  String get backToLogin {
    return Intl.message(
      'Back to Login',
      name: 'backToLogin',
      desc: '',
      args: [],
    );
  }

  /// `By creating an account, you agree to Amber Hearth's `
  String get termsPrefix {
    return Intl.message(
      'By creating an account, you agree to Amber Hearth\'s ',
      name: 'termsPrefix',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service`
  String get termsOfService {
    return Intl.message(
      'Terms of Service',
      name: 'termsOfService',
      desc: '',
      args: [],
    );
  }

  /// ` and `
  String get termsAnd {
    return Intl.message(' and ', name: 'termsAnd', desc: '', args: []);
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `.`
  String get termsDot {
    return Intl.message('.', name: 'termsDot', desc: '', args: []);
  }

  /// `Registration successful!`
  String get registerSuccess {
    return Intl.message(
      'Registration successful!',
      name: 'registerSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Registration failed. Please try again later.`
  String get registerFailed {
    return Intl.message(
      'Registration failed. Please try again later.',
      name: 'registerFailed',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred`
  String get unexpectedError {
    return Intl.message(
      'An unexpected error occurred',
      name: 'unexpectedError',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get profileTitle {
    return Intl.message('Account', name: 'profileTitle', desc: '', args: []);
  }

  /// `Edit Profile`
  String get profileEditProfile {
    return Intl.message(
      'Edit Profile',
      name: 'profileEditProfile',
      desc: '',
      args: [],
    );
  }

  /// `Update personal info`
  String get profileEditProfileDesc {
    return Intl.message(
      'Update personal info',
      name: 'profileEditProfileDesc',
      desc: '',
      args: [],
    );
  }

  /// `My Addresses`
  String get profileMyAddresses {
    return Intl.message(
      'My Addresses',
      name: 'profileMyAddresses',
      desc: '',
      args: [],
    );
  }

  /// `Manage delivery addresses`
  String get profileMyAddressesDesc {
    return Intl.message(
      'Manage delivery addresses',
      name: 'profileMyAddressesDesc',
      desc: '',
      args: [],
    );
  }

  /// `Payment Methods`
  String get profilePaymentMethods {
    return Intl.message(
      'Payment Methods',
      name: 'profilePaymentMethods',
      desc: '',
      args: [],
    );
  }

  /// `Add or remove cards`
  String get profilePaymentMethodsDesc {
    return Intl.message(
      'Add or remove cards',
      name: 'profilePaymentMethodsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Security`
  String get profileSecurity {
    return Intl.message(
      'Security',
      name: 'profileSecurity',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get profileChangePassword {
    return Intl.message(
      'Change Password',
      name: 'profileChangePassword',
      desc: '',
      args: [],
    );
  }

  /// `Update password regularly`
  String get profileChangePasswordDesc {
    return Intl.message(
      'Update password regularly',
      name: 'profileChangePasswordDesc',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get profileSupport {
    return Intl.message('Support', name: 'profileSupport', desc: '', args: []);
  }

  /// `Customer Support`
  String get profileCustomerSupport {
    return Intl.message(
      'Customer Support',
      name: 'profileCustomerSupport',
      desc: '',
      args: [],
    );
  }

  /// `Chat with CS 24/7`
  String get profileCustomerSupportDesc {
    return Intl.message(
      'Chat with CS 24/7',
      name: 'profileCustomerSupportDesc',
      desc: '',
      args: [],
    );
  }

  /// `Help & FAQ`
  String get profileHelpFAQ {
    return Intl.message(
      'Help & FAQ',
      name: 'profileHelpFAQ',
      desc: '',
      args: [],
    );
  }

  /// `Frequently asked questions`
  String get profileHelpFAQDesc {
    return Intl.message(
      'Frequently asked questions',
      name: 'profileHelpFAQDesc',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Policies`
  String get profileTermsPolicies {
    return Intl.message(
      'Terms & Policies',
      name: 'profileTermsPolicies',
      desc: '',
      args: [],
    );
  }

  /// `Usage rules`
  String get profileTermsPoliciesDesc {
    return Intl.message(
      'Usage rules',
      name: 'profileTermsPoliciesDesc',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get profileLogout {
    return Intl.message('Log Out', name: 'profileLogout', desc: '', args: []);
  }

  /// `Settings`
  String get settingsTitle {
    return Intl.message('Settings', name: 'settingsTitle', desc: '', args: []);
  }

  /// `Notifications`
  String get settingsNotifications {
    return Intl.message(
      'Notifications',
      name: 'settingsNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Push Notifications`
  String get settingsPushNotifications {
    return Intl.message(
      'Push Notifications',
      name: 'settingsPushNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Receive app notifications`
  String get settingsPushNotificationsDesc {
    return Intl.message(
      'Receive app notifications',
      name: 'settingsPushNotificationsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Order Updates`
  String get settingsOrderUpdates {
    return Intl.message(
      'Order Updates',
      name: 'settingsOrderUpdates',
      desc: '',
      args: [],
    );
  }

  /// `Real-time delivery status`
  String get settingsOrderUpdatesDesc {
    return Intl.message(
      'Real-time delivery status',
      name: 'settingsOrderUpdatesDesc',
      desc: '',
      args: [],
    );
  }

  /// `Promotions`
  String get settingsPromotions {
    return Intl.message(
      'Promotions',
      name: 'settingsPromotions',
      desc: '',
      args: [],
    );
  }

  /// `Deals and offers`
  String get settingsPromotionsDesc {
    return Intl.message(
      'Deals and offers',
      name: 'settingsPromotionsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Appearance`
  String get settingsAppearance {
    return Intl.message(
      'Appearance',
      name: 'settingsAppearance',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get settingsDarkMode {
    return Intl.message(
      'Dark Mode',
      name: 'settingsDarkMode',
      desc: '',
      args: [],
    );
  }

  /// `Protect eyes at night`
  String get settingsDarkModeDesc {
    return Intl.message(
      'Protect eyes at night',
      name: 'settingsDarkModeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get settingsLanguage {
    return Intl.message(
      'Language',
      name: 'settingsLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Privacy`
  String get settingsPrivacy {
    return Intl.message('Privacy', name: 'settingsPrivacy', desc: '', args: []);
  }

  /// `Privacy Policy`
  String get settingsPrivacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'settingsPrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `How we protect data`
  String get settingsPrivacyPolicyDesc {
    return Intl.message(
      'How we protect data',
      name: 'settingsPrivacyPolicyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Use`
  String get settingsTermsOfUse {
    return Intl.message(
      'Terms of Use',
      name: 'settingsTermsOfUse',
      desc: '',
      args: [],
    );
  }

  /// `Rules and conditions`
  String get settingsTermsOfUseDesc {
    return Intl.message(
      'Rules and conditions',
      name: 'settingsTermsOfUseDesc',
      desc: '',
      args: [],
    );
  }

  /// `Cookie & Tracking`
  String get settingsCookieTracking {
    return Intl.message(
      'Cookie & Tracking',
      name: 'settingsCookieTracking',
      desc: '',
      args: [],
    );
  }

  /// `Manage preferences`
  String get settingsCookieTrackingDesc {
    return Intl.message(
      'Manage preferences',
      name: 'settingsCookieTrackingDesc',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get settingsAbout {
    return Intl.message('About', name: 'settingsAbout', desc: '', args: []);
  }

  /// `About App`
  String get settingsAboutApp {
    return Intl.message(
      'About App',
      name: 'settingsAboutApp',
      desc: '',
      args: [],
    );
  }

  /// `Version 1.0.0`
  String get settingsAboutAppDesc {
    return Intl.message(
      'Version 1.0.0',
      name: 'settingsAboutAppDesc',
      desc: '',
      args: [],
    );
  }

  /// `Rate App`
  String get settingsRateApp {
    return Intl.message(
      'Rate App',
      name: 'settingsRateApp',
      desc: '',
      args: [],
    );
  }

  /// `Share your experience`
  String get settingsRateAppDesc {
    return Intl.message(
      'Share your experience',
      name: 'settingsRateAppDesc',
      desc: '',
      args: [],
    );
  }

  /// `Share App`
  String get settingsShareApp {
    return Intl.message(
      'Share App',
      name: 'settingsShareApp',
      desc: '',
      args: [],
    );
  }

  /// `Refer friends`
  String get settingsShareAppDesc {
    return Intl.message(
      'Refer friends',
      name: 'settingsShareAppDesc',
      desc: '',
      args: [],
    );
  }

  /// `Danger Zone`
  String get settingsDangerZone {
    return Intl.message(
      'Danger Zone',
      name: 'settingsDangerZone',
      desc: '',
      args: [],
    );
  }

  /// `Clear Cache`
  String get settingsClearCache {
    return Intl.message(
      'Clear Cache',
      name: 'settingsClearCache',
      desc: '',
      args: [],
    );
  }

  /// `Free up memory`
  String get settingsClearCacheDesc {
    return Intl.message(
      'Free up memory',
      name: 'settingsClearCacheDesc',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get settingsDeleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'settingsDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Permanently delete all data`
  String get settingsDeleteAccountDesc {
    return Intl.message(
      'Permanently delete all data',
      name: 'settingsDeleteAccountDesc',
      desc: '',
      args: [],
    );
  }

  /// `Choose Language`
  String get settingsLanguageTitle {
    return Intl.message(
      'Choose Language',
      name: 'settingsLanguageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Edit Address`
  String get addressEditTitle {
    return Intl.message(
      'Edit Address',
      name: 'addressEditTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add New Address`
  String get addressAddTitle {
    return Intl.message(
      'Add New Address',
      name: 'addressAddTitle',
      desc: '',
      args: [],
    );
  }

  /// `Address Type`
  String get addressType {
    return Intl.message(
      'Address Type',
      name: 'addressType',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get addressHome {
    return Intl.message('Home', name: 'addressHome', desc: '', args: []);
  }

  /// `Work`
  String get addressWork {
    return Intl.message('Work', name: 'addressWork', desc: '', args: []);
  }

  /// `School`
  String get addressSchool {
    return Intl.message('School', name: 'addressSchool', desc: '', args: []);
  }

  /// `Other`
  String get addressOther {
    return Intl.message('Other', name: 'addressOther', desc: '', args: []);
  }

  /// `Address Info`
  String get addressInfo {
    return Intl.message(
      'Address Info',
      name: 'addressInfo',
      desc: '',
      args: [],
    );
  }

  /// `Address Label`
  String get addressLabel {
    return Intl.message(
      'Address Label',
      name: 'addressLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g., Home, Work...`
  String get addressLabelHint {
    return Intl.message(
      'e.g., Home, Work...',
      name: 'addressLabelHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter address label`
  String get addressLabelRequired {
    return Intl.message(
      'Please enter address label',
      name: 'addressLabelRequired',
      desc: '',
      args: [],
    );
  }

  /// `Recipient Name`
  String get addressRecipientName {
    return Intl.message(
      'Recipient Name',
      name: 'addressRecipientName',
      desc: '',
      args: [],
    );
  }

  /// `Enter recipient name`
  String get addressRecipientHint {
    return Intl.message(
      'Enter recipient name',
      name: 'addressRecipientHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter recipient name`
  String get addressRecipientRequired {
    return Intl.message(
      'Please enter recipient name',
      name: 'addressRecipientRequired',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get addressPhone {
    return Intl.message(
      'Phone Number',
      name: 'addressPhone',
      desc: '',
      args: [],
    );
  }

  /// `Enter phone number`
  String get addressPhoneHint {
    return Intl.message(
      'Enter phone number',
      name: 'addressPhoneHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter phone number`
  String get addressPhoneRequired {
    return Intl.message(
      'Please enter phone number',
      name: 'addressPhoneRequired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number`
  String get addressPhoneInvalid {
    return Intl.message(
      'Invalid phone number',
      name: 'addressPhoneInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Address Details`
  String get addressDetails {
    return Intl.message(
      'Address Details',
      name: 'addressDetails',
      desc: '',
      args: [],
    );
  }

  /// `Detailed Address`
  String get addressLine {
    return Intl.message(
      'Detailed Address',
      name: 'addressLine',
      desc: '',
      args: [],
    );
  }

  /// `House number, street name...`
  String get addressLineHint {
    return Intl.message(
      'House number, street name...',
      name: 'addressLineHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter detailed address`
  String get addressLineRequired {
    return Intl.message(
      'Please enter detailed address',
      name: 'addressLineRequired',
      desc: '',
      args: [],
    );
  }

  /// `Ward/Commune`
  String get addressWard {
    return Intl.message(
      'Ward/Commune',
      name: 'addressWard',
      desc: '',
      args: [],
    );
  }

  /// `Enter ward/commune`
  String get addressWardHint {
    return Intl.message(
      'Enter ward/commune',
      name: 'addressWardHint',
      desc: '',
      args: [],
    );
  }

  /// `District`
  String get addressDistrict {
    return Intl.message(
      'District',
      name: 'addressDistrict',
      desc: '',
      args: [],
    );
  }

  /// `Enter district`
  String get addressDistrictHint {
    return Intl.message(
      'Enter district',
      name: 'addressDistrictHint',
      desc: '',
      args: [],
    );
  }

  /// `City/Province`
  String get addressCity {
    return Intl.message(
      'City/Province',
      name: 'addressCity',
      desc: '',
      args: [],
    );
  }

  /// `Enter city/province`
  String get addressCityHint {
    return Intl.message(
      'Enter city/province',
      name: 'addressCityHint',
      desc: '',
      args: [],
    );
  }

  /// `Postal Code`
  String get addressPostalCode {
    return Intl.message(
      'Postal Code',
      name: 'addressPostalCode',
      desc: '',
      args: [],
    );
  }

  /// `Optional`
  String get addressPostalCodeHint {
    return Intl.message(
      'Optional',
      name: 'addressPostalCodeHint',
      desc: '',
      args: [],
    );
  }

  /// `Required`
  String get addressRequiredField {
    return Intl.message(
      'Required',
      name: 'addressRequiredField',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get addressSave {
    return Intl.message(
      'Save Changes',
      name: 'addressSave',
      desc: '',
      args: [],
    );
  }

  /// `Add Address`
  String get addressAdd {
    return Intl.message('Add Address', name: 'addressAdd', desc: '', args: []);
  }

  /// `Delete`
  String get addressDelete {
    return Intl.message('Delete', name: 'addressDelete', desc: '', args: []);
  }

  /// `Get Current Location`
  String get addressGetCurrentLocation {
    return Intl.message(
      'Get Current Location',
      name: 'addressGetCurrentLocation',
      desc: '',
      args: [],
    );
  }

  /// `Auto fill from GPS`
  String get addressAutoFillLocation {
    return Intl.message(
      'Auto fill from GPS',
      name: 'addressAutoFillLocation',
      desc: '',
      args: [],
    );
  }

  /// `Getting location...`
  String get addressGettingLocation {
    return Intl.message(
      'Getting location...',
      name: 'addressGettingLocation',
      desc: '',
      args: [],
    );
  }

  /// `Customer Support`
  String get supportChatTitle {
    return Intl.message(
      'Customer Support',
      name: 'supportChatTitle',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get supportStatusActive {
    return Intl.message(
      'Active',
      name: 'supportStatusActive',
      desc: '',
      args: [],
    );
  }

  /// `End Conversation`
  String get supportEndConversation {
    return Intl.message(
      'End Conversation',
      name: 'supportEndConversation',
      desc: '',
      args: [],
    );
  }

  /// `End Conversation`
  String get supportEndConfirmationTitle {
    return Intl.message(
      'End Conversation',
      name: 'supportEndConfirmationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to end this conversation? You can start a new one at any time.`
  String get supportEndConfirmationDesc {
    return Intl.message(
      'Are you sure you want to end this conversation? You can start a new one at any time.',
      name: 'supportEndConfirmationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get supportCancel {
    return Intl.message('Cancel', name: 'supportCancel', desc: '', args: []);
  }

  /// `End`
  String get supportEnd {
    return Intl.message('End', name: 'supportEnd', desc: '', args: []);
  }

  /// `Conversation ended`
  String get supportConversationEnded {
    return Intl.message(
      'Conversation ended',
      name: 'supportConversationEnded',
      desc: '',
      args: [],
    );
  }

  /// `Start new conversation`
  String get supportNewConversation {
    return Intl.message(
      'Start new conversation',
      name: 'supportNewConversation',
      desc: '',
      args: [],
    );
  }

  /// `Started new conversation`
  String get supportNewConversationStarted {
    return Intl.message(
      'Started new conversation',
      name: 'supportNewConversationStarted',
      desc: '',
      args: [],
    );
  }

  /// `Conversation has ended`
  String get supportConversationEndedBanner {
    return Intl.message(
      'Conversation has ended',
      name: 'supportConversationEndedBanner',
      desc: '',
      args: [],
    );
  }

  /// `Create new`
  String get supportCreateNew {
    return Intl.message(
      'Create new',
      name: 'supportCreateNew',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred`
  String get supportErrorTitle {
    return Intl.message(
      'An error occurred',
      name: 'supportErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get supportRetry {
    return Intl.message('Retry', name: 'supportRetry', desc: '', args: []);
  }

  /// `Welcome!`
  String get supportWelcome {
    return Intl.message('Welcome!', name: 'supportWelcome', desc: '', args: []);
  }

  /// `Send a message to start a conversation with the support team`
  String get supportWelcomeDesc {
    return Intl.message(
      'Send a message to start a conversation with the support team',
      name: 'supportWelcomeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Conversation ended. Press menu to create a new one.`
  String get supportFooterClosed {
    return Intl.message(
      'Conversation ended. Press menu to create a new one.',
      name: 'supportFooterClosed',
      desc: '',
      args: [],
    );
  }

  /// `Cannot select attachment`
  String get supportAttachmentError {
    return Intl.message(
      'Cannot select attachment',
      name: 'supportAttachmentError',
      desc: '',
      args: [],
    );
  }

  /// `Video must not exceed 10MB`
  String get supportVideoSizeError {
    return Intl.message(
      'Video must not exceed 10MB',
      name: 'supportVideoSizeError',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notificationTitle {
    return Intl.message(
      'Notifications',
      name: 'notificationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Mark all as read`
  String get notificationMarkAllRead {
    return Intl.message(
      'Mark all as read',
      name: 'notificationMarkAllRead',
      desc: '',
      args: [],
    );
  }

  /// `No notifications`
  String get notificationEmptyTitle {
    return Intl.message(
      'No notifications',
      name: 'notificationEmptyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Notifications will appear here`
  String get notificationEmptyDesc {
    return Intl.message(
      'Notifications will appear here',
      name: 'notificationEmptyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Just now`
  String get notificationTimeJustNow {
    return Intl.message(
      'Just now',
      name: 'notificationTimeJustNow',
      desc: '',
      args: [],
    );
  }

  /// `{minutes} minutes ago`
  String notificationTimeMinutes(Object minutes) {
    return Intl.message(
      '$minutes minutes ago',
      name: 'notificationTimeMinutes',
      desc: '',
      args: [minutes],
    );
  }

  /// `{hours} hours ago`
  String notificationTimeHours(Object hours) {
    return Intl.message(
      '$hours hours ago',
      name: 'notificationTimeHours',
      desc: '',
      args: [hours],
    );
  }

  /// `{days} days ago`
  String notificationTimeDays(Object days) {
    return Intl.message(
      '$days days ago',
      name: 'notificationTimeDays',
      desc: '',
      args: [days],
    );
  }

  /// `Checkout`
  String get checkoutTitle {
    return Intl.message('Checkout', name: 'checkoutTitle', desc: '', args: []);
  }

  /// `Calculating price...`
  String get checkoutLoadingPrice {
    return Intl.message(
      'Calculating price...',
      name: 'checkoutLoadingPrice',
      desc: '',
      args: [],
    );
  }

  /// `Cannot get price from server. Tap to retry.`
  String get checkoutErrorPrice {
    return Intl.message(
      'Cannot get price from server. Tap to retry.',
      name: 'checkoutErrorPrice',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Address`
  String get checkoutAddressTitle {
    return Intl.message(
      'Delivery Address',
      name: 'checkoutAddressTitle',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get checkoutPaymentMethodTitle {
    return Intl.message(
      'Payment Method',
      name: 'checkoutPaymentMethodTitle',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get checkoutOrderDetailsTitle {
    return Intl.message(
      'Order Details',
      name: 'checkoutOrderDetailsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Promotion / Voucher`
  String get checkoutPromoTitle {
    return Intl.message(
      'Promotion / Voucher',
      name: 'checkoutPromoTitle',
      desc: '',
      args: [],
    );
  }

  /// `Notes (optional)`
  String get checkoutNotesTitle {
    return Intl.message(
      'Notes (optional)',
      name: 'checkoutNotesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select or enter code`
  String get checkoutSelectPromo {
    return Intl.message(
      'Select or enter code',
      name: 'checkoutSelectPromo',
      desc: '',
      args: [],
    );
  }

  /// `Selected {count} codes`
  String checkoutSelectedPromo(Object count) {
    return Intl.message(
      'Selected $count codes',
      name: 'checkoutSelectedPromo',
      desc: '',
      args: [count],
    );
  }

  /// `Please select a delivery address`
  String get checkoutAddressRequired {
    return Intl.message(
      'Please select a delivery address',
      name: 'checkoutAddressRequired',
      desc: '',
      args: [],
    );
  }

  /// `Items unavailable`
  String get checkoutUnavailableItemsTitle {
    return Intl.message(
      'Items unavailable',
      name: 'checkoutUnavailableItemsTitle',
      desc: '',
      args: [],
    );
  }

  /// `{count} items in your cart are out of stock or unavailable. Please remove them before placing order.`
  String checkoutUnavailableItemsDesc(Object count) {
    return Intl.message(
      '$count items in your cart are out of stock or unavailable. Please remove them before placing order.',
      name: 'checkoutUnavailableItemsDesc',
      desc: '',
      args: [count],
    );
  }

  /// `Understood`
  String get checkoutUnderstood {
    return Intl.message(
      'Understood',
      name: 'checkoutUnderstood',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get checkoutPayBtn {
    return Intl.message('Pay', name: 'checkoutPayBtn', desc: '', args: []);
  }

  /// `Place Order`
  String get checkoutOrderBtn {
    return Intl.message(
      'Place Order',
      name: 'checkoutOrderBtn',
      desc: '',
      args: [],
    );
  }

  /// `Attachment`
  String get supportAttachmentTitle {
    return Intl.message(
      'Attachment',
      name: 'supportAttachmentTitle',
      desc: '',
      args: [],
    );
  }

  /// `Image`
  String get supportAttachImage {
    return Intl.message(
      'Image',
      name: 'supportAttachImage',
      desc: '',
      args: [],
    );
  }

  /// `Video`
  String get supportAttachVideo {
    return Intl.message(
      'Video',
      name: 'supportAttachVideo',
      desc: '',
      args: [],
    );
  }

  /// `File`
  String get supportAttachFile {
    return Intl.message('File', name: 'supportAttachFile', desc: '', args: []);
  }

  /// `Type a message...`
  String get supportChatHint {
    return Intl.message(
      'Type a message...',
      name: 'supportChatHint',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get supportDateToday {
    return Intl.message('Today', name: 'supportDateToday', desc: '', args: []);
  }

  /// `Yesterday`
  String get supportDateYesterday {
    return Intl.message(
      'Yesterday',
      name: 'supportDateYesterday',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal`
  String get checkoutSubtotal {
    return Intl.message(
      'Subtotal',
      name: 'checkoutSubtotal',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Fee`
  String get checkoutShippingFee {
    return Intl.message(
      'Shipping Fee',
      name: 'checkoutShippingFee',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get checkoutDiscount {
    return Intl.message(
      'Discount',
      name: 'checkoutDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get checkoutTotal {
    return Intl.message('Total', name: 'checkoutTotal', desc: '', args: []);
  }

  /// `Enter detailed address...`
  String get checkoutAddressHint {
    return Intl.message(
      'Enter detailed address...',
      name: 'checkoutAddressHint',
      desc: '',
      args: [],
    );
  }

  /// `Map feature will be updated soon`
  String get checkoutMapFeatureSoon {
    return Intl.message(
      'Map feature will be updated soon',
      name: 'checkoutMapFeatureSoon',
      desc: '',
      args: [],
    );
  }

  /// `Select on map`
  String get checkoutSelectOnMap {
    return Intl.message(
      'Select on map',
      name: 'checkoutSelectOnMap',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Address`
  String get checkoutDeliveryAddress {
    return Intl.message(
      'Delivery Address',
      name: 'checkoutDeliveryAddress',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get livestreamFilterAll {
    return Intl.message('All', name: 'livestreamFilterAll', desc: '', args: []);
  }

  /// `Street Food`
  String get livestreamFilterStreetFood {
    return Intl.message(
      'Street Food',
      name: 'livestreamFilterStreetFood',
      desc: '',
      args: [],
    );
  }

  /// `Fine Dining`
  String get livestreamFilterFineDining {
    return Intl.message(
      'Fine Dining',
      name: 'livestreamFilterFineDining',
      desc: '',
      args: [],
    );
  }

  /// `Baking`
  String get livestreamFilterBaking {
    return Intl.message(
      'Baking',
      name: 'livestreamFilterBaking',
      desc: '',
      args: [],
    );
  }

  /// `Desserts`
  String get livestreamFilterDesserts {
    return Intl.message(
      'Desserts',
      name: 'livestreamFilterDesserts',
      desc: '',
      args: [],
    );
  }

  /// `Drinks`
  String get livestreamFilterDrinks {
    return Intl.message(
      'Drinks',
      name: 'livestreamFilterDrinks',
      desc: '',
      args: [],
    );
  }

  /// `LIVE NOW`
  String get livestreamLiveNow {
    return Intl.message(
      'LIVE NOW',
      name: 'livestreamLiveNow',
      desc: '',
      args: [],
    );
  }

  /// `Cannot load livestreams`
  String get livestreamErrorLoad {
    return Intl.message(
      'Cannot load livestreams',
      name: 'livestreamErrorLoad',
      desc: '',
      args: [],
    );
  }

  /// `Network error. Please check your internet connection.`
  String get livestreamErrorNetwork {
    return Intl.message(
      'Network error. Please check your internet connection.',
      name: 'livestreamErrorNetwork',
      desc: '',
      args: [],
    );
  }

  /// `Server is encountering an issue. Please try again later.`
  String get livestreamErrorServer {
    return Intl.message(
      'Server is encountering an issue. Please try again later.',
      name: 'livestreamErrorServer',
      desc: '',
      args: [],
    );
  }

  /// `Session expired. Please log in again.`
  String get livestreamErrorAuth {
    return Intl.message(
      'Session expired. Please log in again.',
      name: 'livestreamErrorAuth',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred. Please try again.`
  String get livestreamErrorGeneric {
    return Intl.message(
      'An error occurred. Please try again.',
      name: 'livestreamErrorGeneric',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong`
  String get livestreamErrorOops {
    return Intl.message(
      'Oops! Something went wrong',
      name: 'livestreamErrorOops',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get livestreamTryAgain {
    return Intl.message(
      'Try Again',
      name: 'livestreamTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `No Livestreams Yet`
  String get livestreamEmptyTitle {
    return Intl.message(
      'No Livestreams Yet',
      name: 'livestreamEmptyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Check back later for live sessions`
  String get livestreamEmptyDesc {
    return Intl.message(
      'Check back later for live sessions',
      name: 'livestreamEmptyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Connecting to livestream...`
  String get livestreamConnecting {
    return Intl.message(
      'Connecting to livestream...',
      name: 'livestreamConnecting',
      desc: '',
      args: [],
    );
  }

  /// `Initializing...`
  String get livestreamInitializing {
    return Intl.message(
      'Initializing...',
      name: 'livestreamInitializing',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for streamer...`
  String get livestreamWaitingStreamer {
    return Intl.message(
      'Waiting for streamer...',
      name: 'livestreamWaitingStreamer',
      desc: '',
      args: [],
    );
  }

  /// `Write a comment...`
  String get livestreamWriteComment {
    return Intl.message(
      'Write a comment...',
      name: 'livestreamWriteComment',
      desc: '',
      args: [],
    );
  }

  /// `Premium Store`
  String get iapStoreTitle {
    return Intl.message(
      'Premium Store',
      name: 'iapStoreTitle',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe`
  String get iapStoreTabSubscribe {
    return Intl.message(
      'Subscribe',
      name: 'iapStoreTabSubscribe',
      desc: '',
      args: [],
    );
  }

  /// `Credits`
  String get iapStoreTabCredits {
    return Intl.message(
      'Credits',
      name: 'iapStoreTabCredits',
      desc: '',
      args: [],
    );
  }

  /// `Features`
  String get iapStoreTabFeatures {
    return Intl.message(
      'Features',
      name: 'iapStoreTabFeatures',
      desc: '',
      args: [],
    );
  }

  /// `Choose a category`
  String get iapStoreChooseCategory {
    return Intl.message(
      'Choose a category',
      name: 'iapStoreChooseCategory',
      desc: '',
      args: [],
    );
  }

  /// `Subscriptions`
  String get iapStoreSubscriptions {
    return Intl.message(
      'Subscriptions',
      name: 'iapStoreSubscriptions',
      desc: '',
      args: [],
    );
  }

  /// `Premium plans`
  String get iapStorePremiumPlans {
    return Intl.message(
      'Premium plans',
      name: 'iapStorePremiumPlans',
      desc: '',
      args: [],
    );
  }

  /// `Buy delivery credits`
  String get iapStoreBuyCredits {
    return Intl.message(
      'Buy delivery credits',
      name: 'iapStoreBuyCredits',
      desc: '',
      args: [],
    );
  }

  /// `Unlock forever`
  String get iapStoreUnlockForever {
    return Intl.message(
      'Unlock forever',
      name: 'iapStoreUnlockForever',
      desc: '',
      args: [],
    );
  }

  /// `All Store`
  String get iapStoreAllStore {
    return Intl.message(
      'All Store',
      name: 'iapStoreAllStore',
      desc: '',
      args: [],
    );
  }

  /// `Browse everything`
  String get iapStoreBrowseAll {
    return Intl.message(
      'Browse everything',
      name: 'iapStoreBrowseAll',
      desc: '',
      args: [],
    );
  }

  /// `Credits & Vouchers`
  String get iapCreditsVouchersTitle {
    return Intl.message(
      'Credits & Vouchers',
      name: 'iapCreditsVouchersTitle',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get iapRetry {
    return Intl.message('Retry', name: 'iapRetry', desc: '', args: []);
  }

  /// `Delivery Credits`
  String get iapDeliveryCredits {
    return Intl.message(
      'Delivery Credits',
      name: 'iapDeliveryCredits',
      desc: '',
      args: [],
    );
  }

  /// `Vouchers`
  String get iapVouchers {
    return Intl.message('Vouchers', name: 'iapVouchers', desc: '', args: []);
  }

  /// `Gift Cards`
  String get iapGiftCards {
    return Intl.message('Gift Cards', name: 'iapGiftCards', desc: '', args: []);
  }

  /// `My Vouchers`
  String get iapMyVouchers {
    return Intl.message(
      'My Vouchers',
      name: 'iapMyVouchers',
      desc: '',
      args: [],
    );
  }

  /// `Credits Balance`
  String get iapCreditsBalance {
    return Intl.message(
      'Credits Balance',
      name: 'iapCreditsBalance',
      desc: '',
      args: [],
    );
  }

  /// `Buy`
  String get iapBuy {
    return Intl.message('Buy', name: 'iapBuy', desc: '', args: []);
  }

  /// `Code`
  String get iapCode {
    return Intl.message('Code', name: 'iapCode', desc: '', args: []);
  }

  /// `Expired`
  String get iapExpired {
    return Intl.message('Expired', name: 'iapExpired', desc: '', args: []);
  }

  /// `Expires: {date}`
  String iapExpires(Object date) {
    return Intl.message(
      'Expires: $date',
      name: 'iapExpires',
      desc: '',
      args: [date],
    );
  }

  /// `OFF`
  String get iapOff {
    return Intl.message('OFF', name: 'iapOff', desc: '', args: []);
  }

  /// `Unlock Features`
  String get iapUnlockFeaturesTitle {
    return Intl.message(
      'Unlock Features',
      name: 'iapUnlockFeaturesTitle',
      desc: '',
      args: [],
    );
  }

  /// `⭐ Popular Features`
  String get iapPopularFeatures {
    return Intl.message(
      '⭐ Popular Features',
      name: 'iapPopularFeatures',
      desc: '',
      args: [],
    );
  }

  /// `👑 Premium Features`
  String get iapPremiumFeatures {
    return Intl.message(
      '👑 Premium Features',
      name: 'iapPremiumFeatures',
      desc: '',
      args: [],
    );
  }

  /// `🎯 All Features`
  String get iapAllFeatures {
    return Intl.message(
      '🎯 All Features',
      name: 'iapAllFeatures',
      desc: '',
      args: [],
    );
  }

  /// `Unlocked Features`
  String get iapUnlockedFeatures {
    return Intl.message(
      'Unlocked Features',
      name: 'iapUnlockedFeatures',
      desc: '',
      args: [],
    );
  }

  /// `🎉 All features unlocked!`
  String get iapAllFeaturesUnlocked {
    return Intl.message(
      '🎉 All features unlocked!',
      name: 'iapAllFeaturesUnlocked',
      desc: '',
      args: [],
    );
  }

  /// `{count} features remaining`
  String iapFeaturesRemaining(Object count) {
    return Intl.message(
      '$count features remaining',
      name: 'iapFeaturesRemaining',
      desc: '',
      args: [count],
    );
  }

  /// `UNLOCKED`
  String get iapUnlocked {
    return Intl.message('UNLOCKED', name: 'iapUnlocked', desc: '', args: []);
  }

  /// `Unlocked on {date}`
  String iapUnlockedOn(Object date) {
    return Intl.message(
      'Unlocked on $date',
      name: 'iapUnlockedOn',
      desc: '',
      args: [date],
    );
  }

  /// `Unlock`
  String get iapUnlock {
    return Intl.message('Unlock', name: 'iapUnlock', desc: '', args: []);
  }

  /// `Choose Your Plan`
  String get iapChoosePlan {
    return Intl.message(
      'Choose Your Plan',
      name: 'iapChoosePlan',
      desc: '',
      args: [],
    );
  }

  /// `Restore Purchases`
  String get iapRestorePurchases {
    return Intl.message(
      'Restore Purchases',
      name: 'iapRestorePurchases',
      desc: '',
      args: [],
    );
  }

  /// `Current Plan`
  String get iapCurrentPlan {
    return Intl.message(
      'Current Plan',
      name: 'iapCurrentPlan',
      desc: '',
      args: [],
    );
  }

  /// `CURRENT`
  String get iapCurrent {
    return Intl.message('CURRENT', name: 'iapCurrent', desc: '', args: []);
  }

  /// `All Restaurants`
  String get restaurantsAllTitle {
    return Intl.message(
      'All Restaurants',
      name: 'restaurantsAllTitle',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get restaurantsFilterAll {
    return Intl.message(
      'All',
      name: 'restaurantsFilterAll',
      desc: '',
      args: [],
    );
  }

  /// `Fast Delivery`
  String get restaurantsFilterFastDelivery {
    return Intl.message(
      'Fast Delivery',
      name: 'restaurantsFilterFastDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Promotions`
  String get restaurantsFilterPromo {
    return Intl.message(
      'Promotions',
      name: 'restaurantsFilterPromo',
      desc: '',
      args: [],
    );
  }

  /// `Top Rated`
  String get restaurantsFilterTopRated {
    return Intl.message(
      'Top Rated',
      name: 'restaurantsFilterTopRated',
      desc: '',
      args: [],
    );
  }

  /// `Nearby`
  String get restaurantsFilterNearby {
    return Intl.message(
      'Nearby',
      name: 'restaurantsFilterNearby',
      desc: '',
      args: [],
    );
  }

  /// `Free`
  String get restaurantsFreeDelivery {
    return Intl.message(
      'Free',
      name: 'restaurantsFreeDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Error: {message}`
  String restaurantsError(Object message) {
    return Intl.message(
      'Error: $message',
      name: 'restaurantsError',
      desc: '',
      args: [message],
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
