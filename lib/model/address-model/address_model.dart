class AddressDetailModel {
  AddressDetailModel({
    required this.location,
    required this.id,
    required this.userId,
    required this.area,
    required this.streetName,
    required this.landMark,
    required this.city,
    required this.pincode,
    required this.state,
    required this.country,
    required this.addressType,
    required this.isDefault,
    required this.isActive,
    required this.isDeleted,
    required this.name,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
  });

  final Location? location;
  final String id;
  final UserId? userId;
  final String area;
  final String streetName;
  final String landMark;
  final String city;
  final String pincode;
  final String state;
  final String country;
  final String addressType;
  final bool isDefault;
  final bool isActive;
  final bool isDeleted;
  final String name;
  final String phone;
  final String? createdAt;
  final String? updatedAt;

  AddressDetailModel copyWith({
    Location? location,
    String? id,
    UserId? userId,
    String? area,
    String? streetName,
    String? landMark,
    String? city,
    String? pincode,
    String? state,
    String? country,
    String? addressType,
    bool? isDefault,
    bool? isActive,
    bool? isDeleted,
    String? name,
    String? phone,
    String? createdAt,
    String? updatedAt,
  }) {
    return AddressDetailModel(
      location: location ?? this.location,
      id: id ?? this.id,
      userId: userId ?? this.userId,
      area: area ?? this.area,
      streetName: streetName ?? this.streetName,
      landMark: landMark ?? this.landMark,
      city: city ?? this.city,
      pincode: pincode ?? this.pincode,
      state: state ?? this.state,
      country: country ?? this.country,
      addressType: addressType ?? this.addressType,
      isDefault: isDefault ?? this.isDefault,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory AddressDetailModel.fromJson(Map<String, dynamic> json) {
    return AddressDetailModel(
      location:
          json["location"] == null ? null : Location.fromJson(json["location"]),
      id: json["_id"] ?? "",
      userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
      area: json["area"] ?? "",
      streetName: json["streetName"] ?? "",
      landMark: json["landMark"] ?? "",
      city: json["city"] ?? "",
      pincode: json["pincode"] ?? "",
      state: json["state"] ?? "",
      country: json["country"] ?? "",
      addressType: json["addressType"] ?? "",
      isDefault: json["isDefault"] ?? false,
      isActive: json["isActive"] ?? false,
      isDeleted: json["isDeleted"] ?? false,
      name: json["name"] ?? "",
      phone: json["phone"] ?? "",
      createdAt: json["createdAt"] ?? "",
      updatedAt: json["updatedAt"] ?? "",
    );
  }
}

class Location {
  Location({
    required this.type,
    required this.coordinates,
  });

  final String type;
  final List<double> coordinates;

  Location copyWith({
    String? type,
    List<double>? coordinates,
  }) {
    return Location(
      type: type ?? this.type,
      coordinates: coordinates ?? this.coordinates,
    );
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json["type"] ?? "",
      coordinates: json["coordinates"] == null
          ? []
          : List<double>.from(
              json["coordinates"]!.map((x) => double.parse(x.toString()))),
    );
  }
}

class UserId {
  UserId({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.avatar,
    required this.occupation,
    required this.providerId,
    required this.consumerId,
    required this.avalibility,
    required this.isRegistered,
    required this.isActive,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String? dateOfBirth;
  final String gender;
  final String avatar;
  final String occupation;
  final String providerId;
  final String consumerId;
  final bool avalibility;
  final bool isRegistered;
  final bool isActive;
  final dynamic createdBy;
  final String? createdAt;
  final String? updatedAt;

  UserId copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? dateOfBirth,
    String? gender,
    String? avatar,
    String? occupation,
    String? providerId,
    String? consumerId,
    bool? avalibility,
    bool? isRegistered,
    bool? isActive,
    dynamic? createdBy,
    String? createdAt,
    String? updatedAt,
  }) {
    return UserId(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      avatar: avatar ?? this.avatar,
      occupation: occupation ?? this.occupation,
      providerId: providerId ?? this.providerId,
      consumerId: consumerId ?? this.consumerId,
      avalibility: avalibility ?? this.avalibility,
      isRegistered: isRegistered ?? this.isRegistered,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory UserId.fromJson(Map<String, dynamic> json) {
    return UserId(
      id: json["_id"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      dateOfBirth: json["dateOfBirth"],
      gender: json["gender"] ?? "",
      avatar: json["avatar"] ?? "",
      occupation: json["occupation"] ?? "",
      providerId: json["providerId"] ?? "",
      consumerId: json["consumerId"] ?? "",
      avalibility: json["avalibility"] ?? false,
      isRegistered: json["isRegistered"] ?? false,
      isActive: json["isActive"] ?? false,
      createdBy: json["createdBy"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
    );
  }
}
