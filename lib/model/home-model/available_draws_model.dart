class AvailableDrawsModel {
  final String drawId;
  final DateTime drawExpiryDate;
  final Prize prize;
  final int numberOfWinners;

  AvailableDrawsModel({
    required this.drawId,
    required this.drawExpiryDate,
    required this.prize,
    required this.numberOfWinners,
  });

  factory AvailableDrawsModel.fromJson(Map<String, dynamic> json) {
    return AvailableDrawsModel(
      drawId: json['drawId'] ?? '',
      drawExpiryDate:
          DateTime.tryParse(json['drawExpiryDate'] ?? '') ?? DateTime.now(),
      prize: Prize.fromJson(json['prize'] ?? {}),
      numberOfWinners: json['numberOfWinners'] ?? 0,
    );
  }
}

class Prize {
  final String name;
  final String description;
  final List<String> imageUrls;

  Prize({
    required this.name,
    required this.description,
    required this.imageUrls,
  });

  factory Prize.fromJson(Map<String, dynamic> json) {
    return Prize(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrls: json["imageUrls"] != null || json["imageUrls"] != []
          ? List<String>.from(json["imageUrls"])
          : [],
    );
  }
}
