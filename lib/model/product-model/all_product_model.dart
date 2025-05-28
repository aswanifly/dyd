import 'package:flutter/widgets.dart';

class AllProductModel {
  AllProductModel({
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
  final CategoryModel? category;
  final String brand;
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

  AllProductModel copyWith({
    String? id,
    CategoryModel? category,
    String? brand,
    List<String>? images,
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
    required bool isAddedToCard,
  }) {
    return AllProductModel(
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

  factory AllProductModel.fromJson(Map<String, dynamic> json) {
    print('JSON Data: $json'); // Debug the JSON input
    return AllProductModel(
      id: json["_id"] ?? "",
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'])
          : null,
      brand: json["brand"] is String
          ? json["brand"]
          : json["brand"] is Map<String, dynamic>
              ? json["brand"]["name"]?.toString() ?? ""
              : "",
      images: json["images"] != null || json["images"] != []
          ? List<String>.from(json["images"])
          : [],
      productName: json["productName"] ?? "",
      basePrice: (json["basePrice"] ?? 0).toString(),
      salePrice: (json["salePrice"] ?? 0).toString(),
      quantity: json["quantity"] ?? 0,
      description: json["description"] ?? "",
      discount: (json["discount"] ?? 0).toString(),
      isActive: json["isActive"] ?? false,
      admin: json["admin"] is String
          ? json["admin"]
          : json["admin"] is Map<String, dynamic>
              ? json["admin"]["id"]?.toString() ?? ""
              : "",
      isDeleted: json["isDeleted"] ?? false,
      createdAt: json["createdAt"] ?? "",
      updatedAt: json["updatedAt"] ?? "",
    );
  }
}

class CategoryModel {
  final String? id;

  CategoryModel({
    this.id,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] ?? "",
    );
  }
}
