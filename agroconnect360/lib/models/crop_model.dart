enum CropStatus {
  planted,
  growing,
  flowering,
  harvesting,
  harvested,
  sold,
}

enum CropType {
  cocoa,
  cashew,
  cassava,
  yam,
  rice,
  maize,
  vegetables,
  fruits,
  other,
}

class CropModel {
  final String id;
  final String farmId;
  final String farmerId;
  final String cropName;
  final CropType cropType;
  final double areaPlanted; // in hectares or acres
  final String sizeUnit;
  final DateTime plantingDate;
  final DateTime? expectedHarvestDate;
  final DateTime? actualHarvestDate;
  final CropStatus status;
  final double? estimatedYield; // in kg or tons
  final double? actualYield;
  final String? yieldUnit;
  final List<String>? cropImages;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;

  CropModel({
    required this.id,
    required this.farmId,
    required this.farmerId,
    required this.cropName,
    required this.cropType,
    required this.areaPlanted,
    this.sizeUnit = 'hectares',
    required this.plantingDate,
    this.expectedHarvestDate,
    this.actualHarvestDate,
    this.status = CropStatus.planted,
    this.estimatedYield,
    this.actualYield,
    this.yieldUnit = 'kg',
    this.cropImages,
    this.notes,
    required this.createdAt,
    this.updatedAt,
  });

  factory CropModel.fromJson(Map<String, dynamic> json) {
    return CropModel(
      id: json['id'] ?? '',
      farmId: json['farmId'] ?? '',
      farmerId: json['farmerId'] ?? '',
      cropName: json['cropName'] ?? '',
      cropType: CropType.values.firstWhere(
        (e) => e.toString() == 'CropType.${json['cropType']}',
        orElse: () => CropType.other,
      ),
      areaPlanted: (json['areaPlanted'] ?? 0).toDouble(),
      sizeUnit: json['sizeUnit'] ?? 'hectares',
      plantingDate: DateTime.parse(json['plantingDate'] ?? DateTime.now().toIso8601String()),
      expectedHarvestDate: json['expectedHarvestDate'] != null
          ? DateTime.parse(json['expectedHarvestDate'])
          : null,
      actualHarvestDate: json['actualHarvestDate'] != null
          ? DateTime.parse(json['actualHarvestDate'])
          : null,
      status: CropStatus.values.firstWhere(
        (e) => e.toString() == 'CropStatus.${json['status']}',
        orElse: () => CropStatus.planted,
      ),
      estimatedYield: json['estimatedYield']?.toDouble(),
      actualYield: json['actualYield']?.toDouble(),
      yieldUnit: json['yieldUnit'] ?? 'kg',
      cropImages: json['cropImages'] != null
          ? List<String>.from(json['cropImages'])
          : null,
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'farmId': farmId,
      'farmerId': farmerId,
      'cropName': cropName,
      'cropType': cropType.toString().split('.').last,
      'areaPlanted': areaPlanted,
      'sizeUnit': sizeUnit,
      'plantingDate': plantingDate.toIso8601String(),
      'expectedHarvestDate': expectedHarvestDate?.toIso8601String(),
      'actualHarvestDate': actualHarvestDate?.toIso8601String(),
      'status': status.toString().split('.').last,
      'estimatedYield': estimatedYield,
      'actualYield': actualYield,
      'yieldUnit': yieldUnit,
      'cropImages': cropImages,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  CropModel copyWith({
    String? id,
    String? farmId,
    String? farmerId,
    String? cropName,
    CropType? cropType,
    double? areaPlanted,
    String? sizeUnit,
    DateTime? plantingDate,
    DateTime? expectedHarvestDate,
    DateTime? actualHarvestDate,
    CropStatus? status,
    double? estimatedYield,
    double? actualYield,
    String? yieldUnit,
    List<String>? cropImages,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CropModel(
      id: id ?? this.id,
      farmId: farmId ?? this.farmId,
      farmerId: farmerId ?? this.farmerId,
      cropName: cropName ?? this.cropName,
      cropType: cropType ?? this.cropType,
      areaPlanted: areaPlanted ?? this.areaPlanted,
      sizeUnit: sizeUnit ?? this.sizeUnit,
      plantingDate: plantingDate ?? this.plantingDate,
      expectedHarvestDate: expectedHarvestDate ?? this.expectedHarvestDate,
      actualHarvestDate: actualHarvestDate ?? this.actualHarvestDate,
      status: status ?? this.status,
      estimatedYield: estimatedYield ?? this.estimatedYield,
      actualYield: actualYield ?? this.actualYield,
      yieldUnit: yieldUnit ?? this.yieldUnit,
      cropImages: cropImages ?? this.cropImages,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Helper to get days until harvest
  int? get daysUntilHarvest {
    if (expectedHarvestDate == null) return null;
    return expectedHarvestDate!.difference(DateTime.now()).inDays;
  }

  // Helper to get days since planting
  int get daysSincePlanting {
    return DateTime.now().difference(plantingDate).inDays;
  }
}
