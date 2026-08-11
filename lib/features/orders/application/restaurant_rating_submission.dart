/// Application command submitted when a customer rates a completed order.
///
/// It deliberately does not expose the Retrofit DTO so presentation and
/// application code stay independent from the Gateway serialization contract.
final class RestaurantRatingSubmission {
  const RestaurantRatingSubmission({
    required this.orderId,
    required this.rating,
    required this.comment,
  });

  final int orderId;
  final int rating;
  final String comment;
}

abstract interface class RestaurantRatingSubmissionPort {
  Future<void> submit({
    required int restaurantId,
    required RestaurantRatingSubmission submission,
  });
}
