class RecentWinnerModel {
  final String fullName;
  final String email;
  final String image;
  final String phone;
  final String ticketNumber;
  final Prize prize;

  RecentWinnerModel({
    required this.fullName,
    required this.email,
    required this.image,
    required this.phone,
    required this.ticketNumber,
    required this.prize,
  });

  factory RecentWinnerModel.fromJson(Map<String, dynamic> json) {
    return RecentWinnerModel(
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      phone: json['phone'] ?? '',
      ticketNumber: json['ticketNumber'] ?? '',
      prize: Prize.fromJson(json['prize'] ?? {}),
    );
  }
}

class Prize {
  final String name;
  final String description;
  final String image;

  Prize({
    required this.name,
    required this.description,
    required this.image,
  });

  factory Prize.fromJson(Map<String, dynamic> json) {
    return Prize(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
