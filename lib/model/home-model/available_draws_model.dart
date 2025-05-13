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

  Map<String, dynamic> toJson() => {
        'drawId': drawId,
        'drawExpiryDate': drawExpiryDate.toIso8601String(),
        'prize': prize.toJson(),
        'numberOfWinners': numberOfWinners,
      };
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

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'image': image,
      };
}
