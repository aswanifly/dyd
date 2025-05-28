class CheckActiveDiscountModel {
  final bool isActive;
  final String?
      discountCardId; // Nullable since it's absent in the second response
  final DateTime?
      expiryDate; // Nullable since it's absent in the second response

  CheckActiveDiscountModel({
    required this.isActive,
    this.discountCardId,
    this.expiryDate,
  });

  factory CheckActiveDiscountModel.fromJson(Map<String, dynamic> json) {
    return CheckActiveDiscountModel(
      isActive: json['isActive'] ?? false,
      discountCardId: json['discountCardId'] as String?,
      expiryDate: json['expiryDate'] != null
          ? DateTime.tryParse(json['expiryDate'])
          : null,
    );
  }
}
