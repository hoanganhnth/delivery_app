class HomeSuggestedDish {
  const HomeSuggestedDish({
    required this.name,
    required this.image,
    required this.price,
    this.restaurantId,
  });
  final String name;
  final String image;
  final num price;
  final num? restaurantId;
}
