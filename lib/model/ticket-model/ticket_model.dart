class TicketModel {
  final String? id;
  final String? user;
  final String? orderBooking;
  final String? discountCard;
  final String? ticketNumber;
  final DateTime? drawExpiryDate;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? discountCardImage;

  TicketModel(
      {this.id,
      this.user,
      this.orderBooking,
      this.discountCard,
      this.ticketNumber,
      this.drawExpiryDate,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.discountCardImage});

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
        id: json['_id'] as String?,
        user: json['user'] as String?,
        orderBooking: json['orderBooking'] as String?,
        discountCard: json['discountCard'] as String?,
        ticketNumber: json['ticketNumber'] as String?,
        drawExpiryDate: json['drawExpiryDate'] != null
            ? DateTime.tryParse(json['drawExpiryDate'])
            : null,
        status: json['status'] as String?,
        createdAt: json['createdAt'] != null
            ? DateTime.tryParse(json['createdAt'])
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.tryParse(json['updatedAt'])
            : null,
        v: json['__v'] as int?,
        discountCardImage: json["discountCardImage"] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user,
      'orderBooking': orderBooking,
      'discountCard': discountCard,
      'ticketNumber': ticketNumber,
      'drawExpiryDate': drawExpiryDate?.toIso8601String(),
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
    };
  }
}
