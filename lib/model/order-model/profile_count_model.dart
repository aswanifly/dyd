class ProfileCountsModel {
  final String ordersCount;
  final String wishlistCount;
  final String discountCardCount;

  ProfileCountsModel({
    required this.ordersCount,
    required this.wishlistCount,
    required this.discountCardCount,
  });

  factory ProfileCountsModel.fromJson(Map<String, dynamic>? json) {
    return ProfileCountsModel(
        ordersCount: json?['ordersCount'].toString() ?? "0",
        wishlistCount: json?['wishlistCount'].toString() ?? "0",
        discountCardCount: json?['discountCardCount'].toString() ?? "0");
  }
}
