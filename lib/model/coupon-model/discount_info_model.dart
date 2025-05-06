class DiscountInfoModel {
  DiscountInfoModel({
    required this.id,
    required this.image,
    required this.discountPercent,
    required this.price,
    required this.validityInDays,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.isActive,
    required this.endDate,
  });

  final String id;
  final String image;
  final String discountPercent;
  final String price;
  final String validityInDays;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String name;
  final String endDate;
  final bool isActive;

  factory DiscountInfoModel.fromJson(Map<String, dynamic> json){
    return DiscountInfoModel(
      id: json["_id"] ?? "",
      image: json["image"] ?? "",
      discountPercent: json["discountPercent"] ?? "",
      price: json["price"] ?? "",
      validityInDays: json["validityInDays"] ?? "",
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      name: json["name"] ?? "",
      isActive: json["isActive"] ?? false,
      endDate: json["endDate"] ?? "",
    );
  }

}
