class TicketDetailsInfoModel {
  final String? ticketNumber;
  final String? status;
  final DateTime? drawExpiryDate;
  final DateTime? createdAt;
  final DiscountCard? discountCard;
  final OrderBooking? orderBooking;
  final String? price;
  final List<String>? images;

  TicketDetailsInfoModel(
      {this.price,
      this.ticketNumber,
      this.status,
      this.drawExpiryDate,
      this.createdAt,
      this.discountCard,
      this.orderBooking,
      this.images});

  factory TicketDetailsInfoModel.fromJson(Map<String, dynamic> json) {
    return TicketDetailsInfoModel(
        ticketNumber: json['ticketNumber'] as String?,
        status: json['status'] as String?,
        drawExpiryDate: json['drawExpiryDate'] != null
            ? DateTime.tryParse(json['drawExpiryDate'])
            : null,
        createdAt: json['createdAt'] != null
            ? DateTime.tryParse(json['createdAt'])
            : null,
        discountCard: json['discountCard'] != null
            ? DiscountCard.fromJson(json['discountCard'])
            : null,
        orderBooking: json['orderBooking'] != null
            ? OrderBooking.fromJson(json['orderBooking'])
            : null,
        images: json["drawImage"] != null || json["drawImage"] != []
            ? List<String>.from(json["drawImage"])
            : [],
        price: json['price'].toString());
  }

  Map<String, dynamic> toJson() {
    return {
      'ticketNumber': ticketNumber,
      'status': status,
      'drawExpiryDate': drawExpiryDate?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'discountCard': discountCard?.toJson(),
      'orderBooking': orderBooking?.toJson(),
    };
  }
}

class DiscountCard {
  final String? id;
  final String? name;

  DiscountCard({
    this.id,
    this.name,
  });

  factory DiscountCard.fromJson(Map<String, dynamic> json) {
    return DiscountCard(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class OrderBooking {
  final String? id;

  OrderBooking({
    this.id,
  });

  factory OrderBooking.fromJson(Map<String, dynamic> json) {
    return OrderBooking(
      id: json['id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
