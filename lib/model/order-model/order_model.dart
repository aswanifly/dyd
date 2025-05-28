class OrderModel {
  final String orderId;
  final String userId;
  final String bookingId;
  final String orderStatus;
  final String orderTotalAmount;
  final String totalAmount;
  final List<OrderInfo> orderInfos;
  final String overallRating;
  final Address? address;
  final String? createdAt;

  OrderModel(
      {required this.orderId,
      required this.userId,
      required this.bookingId,
      required this.orderStatus,
      required this.orderTotalAmount,
      required this.totalAmount,
      required this.orderInfos,
      required this.overallRating,
      this.address,
      this.createdAt});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'] ?? '',
      userId: json['userId'] ?? '',
      bookingId: json['bookingId'] ?? '',
      orderStatus: json['orderStatus'] ?? '',
      orderTotalAmount: json['orderTotalAmount'].toString() ?? "0",
      totalAmount: json['totalAmount'].toString() ?? "0",
      createdAt: json['createdAt'] ?? "",
      orderInfos: (json['orderInfos'] as List<dynamic>?)
              ?.map((e) => OrderInfo.fromJson(e))
              .toList() ??
          [],
      overallRating: json['overallRating'].toString() ?? "0",
      address:
          json['address'] != null ? Address.fromJson(json['address']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'userId': userId,
        'bookingId': bookingId,
        'orderStatus': orderStatus,
        'orderTotalAmount': orderTotalAmount,
        'totalAmount': totalAmount,
        'orderInfos': orderInfos.map((e) => e.toJson()).toList(),
        'overallRating': overallRating,
        'address': address?.toJson(),
      };
}

class OrderInfo {
  final String orderInfoId;
  final String image;
  final String productName;
  final String? productId;
  final String? rating;
  final String? purchaseQuantity;

  OrderInfo({
    required this.orderInfoId,
    required this.image,
    required this.productName,
    this.productId,
    this.rating,
    this.purchaseQuantity,
  });

  factory OrderInfo.fromJson(Map<String, dynamic> json) {
    return OrderInfo(
        orderInfoId: json['orderInfoId'] ?? '',
        image: json['image'] ?? '',
        productName: json['productName'] ?? "",
        productId: json['productId'] ?? "",
        purchaseQuantity: json['purchaseQuantity'].toString() ?? "1",
        rating: json['rating'].toString() ?? "0");
  }

  Map<String, dynamic> toJson() => {
        'orderInfoId': orderInfoId,
        'image': image,
        'productName': productName,
        'productId': productId,
        'rating': rating,
      };
}

class Address {
  final String fullAddress;
  final String streetName;
  final String city;
  final String state;
  final String pinCode;
  final String country;

  Address({
    required this.fullAddress,
    required this.streetName,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      fullAddress: json['fullAddress'] ?? '',
      streetName: json['streetName'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      pinCode: json['pinCode'] ?? '',
      country: json['country'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'fullAddress': fullAddress,
        'streetName': streetName,
        'city': city,
        'state': state,
        'pinCode': pinCode,
        'country': country,
      };
}
