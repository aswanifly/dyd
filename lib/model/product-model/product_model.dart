class ProductModel {
  ProductModel({
    required this.id,
    required this.category,
    required this.brand,
    required this.image,
    required this.productName,
    required this.basePrice,
    required this.salePrice,
    required this.quantity,
    required this.description,
    required this.discount,
    required this.isActive,
    required this.admin,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String category;
  final String brand;
  final String image;
  final String productName;
  final String basePrice;
  final String salePrice;
  final String quantity;
  final String description;
  final String discount;
  final bool isActive;
  final String admin;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;

  ProductModel copyWith({
    String? id,
    String? category,
    String? brand,
    String? image,
    String? productName,
    String? basePrice,
    String? salePrice,
    String? quantity,
    String? description,
    String? discount,
    bool? isActive,
    String? admin,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      image: image ?? this.image,
      productName: productName ?? this.productName,
      basePrice: basePrice ?? this.basePrice,
      salePrice: salePrice ?? this.salePrice,
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
      discount: discount ?? this.discount,
      isActive: isActive ?? this.isActive,
      admin: admin ?? this.admin,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json){
    return ProductModel(
      id: json["_id"] ?? "",
      category: json["category"] ?? "",
      brand: json["brand"] ?? "",
      image: json["image"] ?? "",
      productName: json["productName"] ?? "",
      basePrice: (json["basePrice"] ?? 0).toString(),
      salePrice: (json["salePrice"] ?? 0).toString(),
      quantity: (json["quantity"] ?? 0).toString(),
      description: json["description"] ?? "",
      discount: (json["discount"] ?? 0).toString(),
      isActive: json["isActive"] ?? false,
      admin: json["admin"] ?? "",
      isDeleted: json["isDeleted"] ?? false,
      createdAt: json["createdAt"] ?? "",
      updatedAt: json["updatedAt"] ?? "",
    );
  }

}
