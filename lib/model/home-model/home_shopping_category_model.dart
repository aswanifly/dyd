class HomeShoppingCategoryModel {
  HomeShoppingCategoryModel({
    required this.id,
    required this.category,
    required this.description,
    required this.image,
    required this.icon,
    required this.admin,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String category;
  final String description;
  final String image;
  final String icon;
  final String admin;
  final bool isActive;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;

  factory HomeShoppingCategoryModel.fromJson(Map<String, dynamic> json){
    return HomeShoppingCategoryModel(
      id: json["_id"] ?? "",
      category: json["category"] ?? "",
      description: json["description"] ?? "",
      image: json["image"] ?? "",
      icon: json["icon"] ?? "",
      admin: json["admin"] ?? "",
      isActive: json["isActive"] ?? false,
      isDeleted: json["isDeleted"] ?? false,
      createdAt: json["createdAt"] ?? "",
      updatedAt: json["updatedAt"] ?? "",
    );
  }

}
