class ProductModel {
  ProductModel({
    required this.id,
    required this.category,
    required this.brand,
    required this.images,
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
  final List<String> images;
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
    List<String>? images,
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
      images: images ?? this.images,
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

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["_id"] ?? "",
      category: json["category"] ?? "",
      brand: json["brand"] ?? "",
      images: json["images"] != null || json["images"] != []
          ? List<String>.from(json["images"])
          : [],
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
