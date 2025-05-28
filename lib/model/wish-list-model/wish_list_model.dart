class WishListProductModel {
  final String id;
  final String user;
  final Product? product;
  final String createdAt;
  final String updatedAt;
  final String v;

  WishListProductModel({
    required this.id,
    required this.user,
    required this.product,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory WishListProductModel.fromJson(Map<String, dynamic> json) {
    return WishListProductModel(
      id: json['_id'] ?? "",
      user: json['user'] ?? "",
      product: json['productId'] != null
          ? Product.fromJson(json['productId'])
          : null,
      createdAt: json['createdAt'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
      v: json['__v'].toString() ?? "0",
    );
  }
}

class Product {
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
  final bool? isActive;
  final String admin;
  final bool? isDeleted;
  final String createdAt;
  final String updatedAt;
  final String v;
  final bool? featuredProducts;
  final bool? hotDeals;

  Product({
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
    required this.v,
    required this.featuredProducts,
    required this.hotDeals,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] ?? "",
      category: json['category'] ?? "",
      brand: json['brand'] ?? "",
      image: json['image'] ?? '',
      productName: json['productName'] ?? '',
      basePrice: json['basePrice'].toString() ?? "0",
      salePrice: json['salePrice'].toString() ?? "0",
      quantity: json['quantity'].toString() ?? "0",
      description: json['description'] ?? '',
      discount: json['discount'].toString() ?? "0",
      isActive: json['isActive'] as bool? ?? false,
      admin: json['admin'] ?? "",
      isDeleted: json['isDeleted'] as bool? ?? false,
      createdAt: json['createdAt'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
      v: json['__v'].toString() ?? "0",
      featuredProducts: json['featuredProducts'] as bool? ?? false,
      hotDeals: json['hotDeals'] as bool? ?? false,
    );
  }
}
