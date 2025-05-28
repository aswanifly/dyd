class CartItemModel {
  final String cartId;
  final List<CartItem> items;
  final String discount;
  final String gst;
  final String subTotal;
  final String finalPrice;
  final String deliveryCharges;

  CartItemModel({
    required this.cartId,
    required this.items,
    required this.discount,
    required this.gst,
    required this.subTotal,
    required this.finalPrice,
    required this.deliveryCharges,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      cartId: json['cartId'] ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map((item) => CartItem.fromJson(item))
              .toList() ??
          [],
      discount: json['discount'].toString() ?? "0",
      gst: json['gst'].toString() ?? "0",
      subTotal: json['subTotal'].toString() ?? "0",
      finalPrice: json['finalPrice'].toString() ?? "0",
      deliveryCharges: json['deliveryCharges'].toString() ?? "0",
    );
  }
}

class CartItem {
  final String id;
  final String product;
  final String productName;
  final String price;
  final int purchaseQuantity;
  final String discount;
  final String gst;
  final String subTotal;
  final String finalPrice;
  final String? image;

  CartItem({
    required this.id,
    required this.product,
    required this.productName,
    required this.price,
    required this.purchaseQuantity,
    required this.discount,
    required this.gst,
    required this.subTotal,
    required this.finalPrice,
    this.image,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['_id'] ?? '',
      product: json['product'] ?? '',
      productName: json['productName'] ?? '',
      price: json['price'].toString() ?? "0",
      purchaseQuantity: json['purchaseQuantity'] ?? "0",
      discount: json['discount'].toString() ?? "0",
      gst: json['gst'].toString() ?? "0",
      subTotal: json['subTotal'].toString() ?? "0",
      finalPrice: json['finalPrice'].toString() ?? "0",
      image: json['image'], // nullable
    );
  }
}
