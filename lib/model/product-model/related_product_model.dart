class RelatedProductModel {
  final String? id;
  final String? productName;
  final List<String>? image;
  final String? description;
  final String? admin;
  final String? createdAt;
  final String? updatedAt;
  final CategoryModel? category;

  final String? basePrice;
  final double? salePrice;
  final int? quantity;
  final int? discount;

  final bool? isActive;
  final bool? isDeleted;
  final bool? hotDeals;
  final bool? featuredProducts;

  RelatedProductModel({
    this.id,
    this.productName,
    this.image,
    this.description,
    this.admin,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.basePrice,
    this.salePrice,
    this.quantity,
    this.discount,
    this.isActive,
    this.isDeleted,
    this.hotDeals,
    this.featuredProducts,
  });

  factory RelatedProductModel.fromJson(Map<String, dynamic> json) {
    return RelatedProductModel(
      id: json['_id'] as String?,
      productName: json['productName'] as String?,
      image: json["images"] != null || json["images"] != []
          ? List<String>.from(json["images"])
          : [],
      description: json['description'] as String?,
      admin: json['admin'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'])
          : null,
      basePrice: json['basePrice'].toString(),
      salePrice: (json['salePrice'] is int)
          ? (json['salePrice'] as int).toDouble()
          : json['salePrice'] as double?,
      quantity: json['quantity'] as int?,
      discount: json['discount'] as int?,
      isActive: json['isActive'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      hotDeals: json['hotDeals'] as bool?,
      featuredProducts: json['featuredProducts'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'productName': productName,
      'image': image,
      'description': description,
      'admin': admin,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'category': category?.toJson(),
      'basePrice': basePrice,
      'salePrice': salePrice,
      'quantity': quantity,
      'discount': discount,
      'isActive': isActive,
      'isDeleted': isDeleted,
      'hotDeals': hotDeals,
      'featuredProducts': featuredProducts,
    };
  }
}

class CategoryModel {
  final String? id;

  CategoryModel({this.id});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
    };
  }
}
