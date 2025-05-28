class HotDealsModel {
  final String? id;
  final String? category;
  final String? image;
  final String? productName;
  final String? basePrice;
  final String? salePrice;
  final String? quantity;
  final String? description;
  final String? discount;
  final bool? isActive;
  final String? admin;
  final bool? isDeleted;
  final bool? hotDeals;
  final bool? featuredProducts;
  final String? createdAt;
  final String? updatedAt;

  HotDealsModel({
    this.id,
    this.category,
    this.image,
    this.productName,
    this.basePrice,
    this.salePrice,
    this.quantity,
    this.description,
    this.discount,
    this.isActive,
    this.admin,
    this.isDeleted,
    this.hotDeals,
    this.featuredProducts,
    this.createdAt,
    this.updatedAt,
  });

  factory HotDealsModel.fromJson(Map<String, dynamic> json) {
    return HotDealsModel(
        id: json['_id'] ?? "",
        category: json['category'] ?? "",
        image: json['image'] ?? "",
        productName: json['productName'] ?? "",
        basePrice: json['basePrice'].toString() ?? "0",
        salePrice: json['salePrice'].toString() ?? "0",
        quantity: json['quantity'].toString() ?? "0",
        description: json['description'] ?? "",
        discount: json['discount'].toString() ?? "0",
        isActive: json['isActive'] ?? false,
        admin: json['admin'] ?? "",
        isDeleted: json['isDeleted'] ?? false,
        hotDeals: json['hotDeals'] ?? false,
        featuredProducts: json['featuredProducts'] ?? false,
        createdAt: json['createdAt'] ?? "",
        updatedAt: json['updatedAt'] ?? "");
  }
}
