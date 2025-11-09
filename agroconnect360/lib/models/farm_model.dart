class FarmModel {
  final String id;
  final String farmerId;
  final String farmName;
  final double farmSize; // in hectares
  final String sizeUnit; // hectares or acres
  final String location;
  final double? latitude;
  final double? longitude;
  final String? soilType;
  final String state;
  final String lga;
  final List<String>? farmImages;
  final DateTime createdAt;
  final DateTime? updatedAt;

  FarmModel({
    required this.id,
    required this.farmerId,
    required this.farmName,
    required this.farmSize,
    this.sizeUnit = 'hectares',
    required this.location,
    this.latitude,
    this.longitude,
    this.soilType,
    required this.state,
    required this.lga,
    this.farmImages,
    required this.createdAt,
    this.updatedAt,
  });

  factory FarmModel.fromJson(Map<String, dynamic> json) {
    return FarmModel(
      id: json['id'] ?? '',
      farmerId: json['farmerId'] ?? '',
      farmName: json['farmName'] ?? '',
      farmSize: (json['farmSize'] ?? 0).toDouble(),
      sizeUnit: json['sizeUnit'] ?? 'hectares',
      location: json['location'] ?? '',
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      soilType: json['soilType'],
      state: json['state'] ?? '',
      lga: json['lga'] ?? '',
      farmImages: json['farmImages'] != null
          ? List<String>.from(json['farmImages'])
          : null,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'farmerId': farmerId,
      'farmName': farmName,
      'farmSize': farmSize,
      'sizeUnit': sizeUnit,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'soilType': soilType,
      'state': state,
      'lga': lga,
      'farmImages': farmImages,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  FarmModel copyWith({
    String? id,
    String? farmerId,
    String? farmName,
    double? farmSize,
    String? sizeUnit,
    String? location,
    double? latitude,
    double? longitude,
    String? soilType,
    String? state,
    String? lga,
    List<String>? farmImages,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FarmModel(
      id: id ?? this.id,
      farmerId: farmerId ?? this.farmerId,
      farmName: farmName ?? this.farmName,
      farmSize: farmSize ?? this.farmSize,
      sizeUnit: sizeUnit ?? this.sizeUnit,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      soilType: soilType ?? this.soilType,
      state: state ?? this.state,
      lga: lga ?? this.lga,
      farmImages: farmImages ?? this.farmImages,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
