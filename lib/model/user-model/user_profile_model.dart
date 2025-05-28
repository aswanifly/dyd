class UserProfileModel {
  final String? id;
  final String? fullName;
  final String? email;
  final String? phone;
  final String image;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<LotteryTicket>? lotteryTickets;
  final DiscountCard? purchasedDisscountCard;

  UserProfileModel({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    required this.image,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.lotteryTickets,
    this.purchasedDisscountCard,
  });
  UserProfileModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phone,
    String? image,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<LotteryTicket>? lotteryTickets,
    DiscountCard? purchasedDisscountCard,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lotteryTickets: lotteryTickets ?? this.lotteryTickets,
      purchasedDisscountCard:
          purchasedDisscountCard ?? this.purchasedDisscountCard,
    );
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['_id'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      isActive: json['isActive'],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      lotteryTickets: (json['lotteryTickets'] as List<dynamic>?)
          ?.map((e) => LotteryTicket.fromJson(e))
          .toList(),
      purchasedDisscountCard: json['purchasedDisscountCard'] != null
          ? DiscountCard.fromJson(json['purchasedDisscountCard'])
          : null,
    );
  }
}

class LotteryTicket {
  final String? id;
  final String? user;
  final String? orderBooking;
  final String? discountCard;
  final String? ticketNumber;
  final DateTime? drawExpiryDate;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  LotteryTicket({
    this.id,
    this.user,
    this.orderBooking,
    this.discountCard,
    this.ticketNumber,
    this.drawExpiryDate,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory LotteryTicket.fromJson(Map<String, dynamic> json) {
    return LotteryTicket(
      id: json['_id'],
      user: json['user'],
      orderBooking: json['orderBooking'],
      discountCard: json['discountCard'],
      ticketNumber: json['ticketNumber'],
      drawExpiryDate: json['drawExpiryDate'] != null
          ? DateTime.tryParse(json['drawExpiryDate'])
          : null,
      status: json['status'],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }
}

class DiscountCard {
  final String? id;
  final String? name;
  final String? image;
  final int? discountPercent;
  final int? price;
  final String? status;
  final DateTime? endDate;
  final int? validityInDays;
  final bool? isSelectedForUser;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DiscountCard({
    this.id,
    this.name,
    this.image,
    this.discountPercent,
    this.price,
    this.status,
    this.endDate,
    this.validityInDays,
    this.isSelectedForUser,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory DiscountCard.fromJson(Map<String, dynamic> json) {
    return DiscountCard(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
      discountPercent: json['discountPercent'],
      price: json['price'],
      status: json['status'],
      endDate:
          json['endDate'] != null ? DateTime.tryParse(json['endDate']) : null,
      validityInDays: json['validityInDays'],
      isSelectedForUser: json['isSelectedForUser'],
      isActive: json['isActive'],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }
}
