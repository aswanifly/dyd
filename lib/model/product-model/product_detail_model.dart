class ProductDetailModel {
  ProductDetailModel(
      {required this.id,
      required this.category,
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
      this.qty = 0,
      this.isWishlisted = false,
      this.isAddedToCard = false});

  final String id;
  final Category? category;
  final List<String> images;
  final String productName;
  final String basePrice;
  final String salePrice;
  final int quantity;
  final String description;
  final String discount;
  final bool isActive;
  final String admin;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;
  final int qty;
  final bool isAddedToCard;
  final bool isWishlisted;

  ProductDetailModel copyWith({
    String? id,
    Category? category,
    String? image,
    String? productName,
    String? basePrice,
    String? salePrice,
    int? quantity,
    String? description,
    String? discount,
    bool? isActive,
    String? admin,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
    int? qty,
    bool? isAddedToCard,
    bool? isWishlisted,
  }) {
    return ProductDetailModel(
      id: id ?? this.id,
      category: category ?? this.category,
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
      isAddedToCard: isAddedToCard ?? this.isAddedToCard,
      qty: qty ?? this.qty,
      isWishlisted: isWishlisted ?? this.isWishlisted,
    );
  }

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
        id: json["_id"] ?? "",
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        images: json["images"] != null || json["images"] != []
            ? List<String>.from(json["images"])
            : [],
        productName: json["productName"] ?? "",
        basePrice: (json["basePrice"] ?? 0).toString(),
        salePrice: (json["salePrice"] ?? 0).toString(),
        quantity: (json["quantity"] ?? 0),
        description: json["description"] ?? "",
        discount: (json["discount"] ?? 0).toString(),
        isActive: json["isActive"] ?? false,
        admin: json["admin"] ?? "",
        isDeleted: json["isDeleted"] ?? false,
        createdAt: json["createdAt"] ?? "",
        updatedAt: json["updatedAt"] ?? "",
        isWishlisted: json["isWishlisted"] ?? false);
  }
}

class Category {
  Category({
    required this.id,
    required this.category,
  });

  final String id;
  final String category;

  Category copyWith({
    String? id,
    String? category,
  }) {
    return Category(
      id: id ?? this.id,
      category: category ?? this.category,
    );
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["_id"] ?? "",
      category: json["category"] ?? "",
    );
  }
}
