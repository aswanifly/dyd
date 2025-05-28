class LuckyCardModel {
  final String id;
  final String user;
  final String orderBooking;
  final String? discountCard;
  final String LuckyCardModelNumber;
  final DateTime drawExpiryDate;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  LuckyCardModel({
    required this.id,
    required this.user,
    required this.orderBooking,
    this.discountCard,
    required this.LuckyCardModelNumber,
    required this.drawExpiryDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory LuckyCardModel.fromJson(Map<String, dynamic> json) {
    return LuckyCardModel(
      id: json['_id'] ?? '',
      user: json['user'] ?? '',
      orderBooking: json['orderBooking'] ?? '',
      discountCard: json['discountCard'],
      LuckyCardModelNumber: json['LuckyCardModelNumber'] ?? '',
      drawExpiryDate:
          DateTime.tryParse(json['drawExpiryDate'] ?? '') ?? DateTime.now(),
      status: json['status'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      v: json['__v'] ?? 0,
    );
  }
}
