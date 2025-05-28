class SelectedAddressModel {
  SelectedAddressModel({
    required this.selectedAddressId,
    required this.selectedAddressText,
    required this.selectedLatitude,
    required this.selectedLongitude,
  });

  final String selectedAddressId;
  final String selectedAddressText;
  final double selectedLatitude;
  final double selectedLongitude;

  SelectedAddressModel copyWith({
    String? selectedAddressId,
    String? selectedAddressText,
    double? selectedLatitude,
    double? selectedLongitude,
  }) {
    return SelectedAddressModel(
      selectedAddressId: selectedAddressId ?? this.selectedAddressId,
      selectedAddressText: selectedAddressText ?? this.selectedAddressText,
      selectedLatitude: selectedLatitude ?? this.selectedLatitude,
      selectedLongitude: selectedLongitude ?? this.selectedLongitude,
    );
  }

  factory SelectedAddressModel.fromJson(Map<String, dynamic> json) {
    return SelectedAddressModel(
      selectedAddressId: json["selectedAddressId"] ?? "",
      selectedAddressText: json["selectedAddressText"] ?? "",
      selectedLatitude: json["selectedLatitude"] ?? 0.0,
      selectedLongitude: json["selectedLongitude"] ?? 0.0,
    );
  }
}
