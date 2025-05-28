class DiscountCardModel {
  final String bookingId;
  final String orderStatus;
  final String paymentStatus;
  final String totalAmount;
  final String createdAt;
  final String discountCardId;
  final DiscountCardDetails? discountCardDetails;
  final String cardStatus;

  DiscountCardModel({
    required this.bookingId,
    required this.orderStatus,
    required this.paymentStatus,
    required this.totalAmount,
    required this.createdAt,
    required this.discountCardId,
    this.discountCardDetails,
    required this.cardStatus,
  });

  factory DiscountCardModel.fromJson(Map<String, dynamic> json) {
    return DiscountCardModel(
      bookingId: json['bookingId'] ?? '',
      orderStatus: json['orderStatus'] ?? '',
      paymentStatus: json['paymentStatus'] ?? '',
      totalAmount: json['totalAmount'].toString(),
      createdAt: json['createdAt'] ?? '',
      discountCardId: json['discountCardId'] ?? '',
      discountCardDetails: json['discountCardDetails'] != null
          ? DiscountCardDetails.fromJson(json['discountCardDetails'])
          : null,
      cardStatus: json['cardStatus'] ?? '',
    );
  }
}

class DiscountCardDetails {
  final String id;
  final String name;
  final String image;
  final int discountPercent;
  final String price;
  final String status;
  final String endDate;
  final int validityInDays;
  final bool isSelectedForUser;
  final String createdAt;
  final String updatedAt;
  final int v;
  final bool isActive;

  DiscountCardDetails({
    required this.id,
    required this.name,
    required this.image,
    required this.discountPercent,
    required this.price,
    required this.status,
    required this.endDate,
    required this.validityInDays,
    required this.isSelectedForUser,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isActive,
  });

  factory DiscountCardDetails.fromJson(Map<String, dynamic> json) {
    return DiscountCardDetails(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      discountPercent: json['discountPercent'] ?? 0,
      price: json['price'].toString() ?? "0",
      status: json['status'] ?? '',
      endDate: json['endDate'] ?? '',
      validityInDays: json['validityInDays'] ?? 0,
      isSelectedForUser: json['isSelectedForUser'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
      isActive: json['isActive'] ?? false,
    );
  }
}
