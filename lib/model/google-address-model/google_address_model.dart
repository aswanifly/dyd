class GoogleMapAddressModel {
  final String state;
  final String country;
  final String streetName;
  final String city;
  final String pincode;
  final String description;
  final String placeId;

  GoogleMapAddressModel({
    required this.state,
    required this.country,
    required this.streetName,
    required this.city,
    required this.pincode,
    required this.description,
    required this.placeId,
  });

  // Factory constructor to create an Address object from JSON
  factory GoogleMapAddressModel.fromJson(Map<String, dynamic> json) {
    List terms = json['terms'];
    String description = json['description'];
    List parts = description.split(',');
    return GoogleMapAddressModel(
      description: json['description'] ?? '',
      streetName: parts.isNotEmpty ? parts.first.trim() : '',
      city: json["structured_formatting"]["main_text"],
      state: parts.length > 2 ? parts[parts.length - 2].trim() : '',
      country: terms.length > 3 ? terms[terms.length - 1]['value'] : '',
      pincode: '',
      placeId: json["place_id"] ?? "",
    );
  }

  // Method to convert the Address object to JSON
  Map<String, dynamic> toJson() {
    return {
      'state': state,
      'country': country,
      'landmark': streetName,
      'city': city,
      'pincode': pincode,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'GoogleMapAddressModel(state: $state, country: $country, landmark: $streetName, city: $city, pincode: $pincode, description: $description)';
  }
}
