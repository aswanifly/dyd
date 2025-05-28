class OrderModel {
  final String orderId;
  final String userId;
  final String bookingId;
  final String orderStatus;
  final int orderTotalAmount;
  final int totalAmount;
  final List<OrderInfo> orderInfos;
  final int? overallRating;
  final Address address;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.bookingId,
    required this.orderStatus,
    required this.orderTotalAmount,
    required this.totalAmount,
    required this.orderInfos,
    this.overallRating,
    required this.address,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'] ?? '',
      userId: json['userId'] ?? '',
      bookingId: json['bookingId'] ?? '',
      orderStatus: json['orderStatus'] ?? '',
      orderTotalAmount: json['orderTotalAmount'] ?? 0,
      totalAmount: json['totalAmount'] ?? 0,
      orderInfos: (json['orderInfos'] as List<dynamic>?)
              ?.map((e) => OrderInfo.fromJson(e))
              .toList() ??
          [],
      overallRating: json['overallRating'],
      address: Address.fromJson(json['address'] ?? {}),
    );
  }
}

class OrderInfo {
  final String orderInfoId;
  final String image;
  final String? productName;
  final String? productId;
  final int? rating;

  OrderInfo({
    required this.orderInfoId,
    required this.image,
    this.productName,
    this.productId,
    this.rating,
  });

  factory OrderInfo.fromJson(Map<String, dynamic> json) {
    return OrderInfo(
      orderInfoId: json['orderInfoId'] ?? '',
      image: json['image'] ?? '',
      productName: json['productName'],
      productId: json['productId'],
      rating: json['rating'],
    );
  }
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
}
