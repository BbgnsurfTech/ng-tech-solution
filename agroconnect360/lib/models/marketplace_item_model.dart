enum ItemCategory {
  seeds,
  fertilizers,
  pesticides,
  equipment,
  produce,
  livestock,
  services,
  other,
}

enum ListingStatus {
  active,
  pending,
  sold,
  expired,
  cancelled,
}

class MarketplaceItemModel {
  final String id;
  final String sellerId;
  final String sellerName;
  final String title;
  final String description;
  final ItemCategory category;
  final double price; // price per unit in Naira
  final String priceUnit; // per kg, per bag, per piece, etc.
  final double quantity;
  final String quantityUnit;
  final ListingStatus status;
  final List<String>? images;
  final String location;
  final String state;
  final String? lga;
  final bool isNegotiable;
  final DateTime? expiryDate;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int views;
  final int inquiries;

  MarketplaceItemModel({
    required this.id,
    required this.sellerId,
    required this.sellerName,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    this.priceUnit = 'unit',
    required this.quantity,
    this.quantityUnit = 'units',
    this.status = ListingStatus.active,
    this.images,
    required this.location,
    required this.state,
    this.lga,
    this.isNegotiable = false,
    this.expiryDate,
    required this.createdAt,
    this.updatedAt,
    this.views = 0,
    this.inquiries = 0,
  });

  factory MarketplaceItemModel.fromJson(Map<String, dynamic> json) {
    return MarketplaceItemModel(
      id: json['id'] ?? '',
      sellerId: json['sellerId'] ?? '',
      sellerName: json['sellerName'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: ItemCategory.values.firstWhere(
        (e) => e.toString() == 'ItemCategory.${json['category']}',
        orElse: () => ItemCategory.other,
      ),
      price: (json['price'] ?? 0).toDouble(),
      priceUnit: json['priceUnit'] ?? 'unit',
      quantity: (json['quantity'] ?? 0).toDouble(),
      quantityUnit: json['quantityUnit'] ?? 'units',
      status: ListingStatus.values.firstWhere(
        (e) => e.toString() == 'ListingStatus.${json['status']}',
        orElse: () => ListingStatus.active,
      ),
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      location: json['location'] ?? '',
      state: json['state'] ?? '',
      lga: json['lga'],
      isNegotiable: json['isNegotiable'] ?? false,
      expiryDate: json['expiryDate'] != null ? DateTime.parse(json['expiryDate']) : null,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      views: json['views'] ?? 0,
      inquiries: json['inquiries'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sellerId': sellerId,
      'sellerName': sellerName,
      'title': title,
      'description': description,
      'category': category.toString().split('.').last,
      'price': price,
      'priceUnit': priceUnit,
      'quantity': quantity,
      'quantityUnit': quantityUnit,
      'status': status.toString().split('.').last,
      'images': images,
      'location': location,
      'state': state,
      'lga': lga,
      'isNegotiable': isNegotiable,
      'expiryDate': expiryDate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'views': views,
      'inquiries': inquiries,
    };
  }

  MarketplaceItemModel copyWith({
    String? id,
    String? sellerId,
    String? sellerName,
    String? title,
    String? description,
    ItemCategory? category,
    double? price,
    String? priceUnit,
    double? quantity,
    String? quantityUnit,
    ListingStatus? status,
    List<String>? images,
    String? location,
    String? state,
    String? lga,
    bool? isNegotiable,
    DateTime? expiryDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? views,
    int? inquiries,
  }) {
    return MarketplaceItemModel(
      id: id ?? this.id,
      sellerId: sellerId ?? this.sellerId,
      sellerName: sellerName ?? this.sellerName,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
      priceUnit: priceUnit ?? this.priceUnit,
      quantity: quantity ?? this.quantity,
      quantityUnit: quantityUnit ?? this.quantityUnit,
      status: status ?? this.status,
      images: images ?? this.images,
      location: location ?? this.location,
      state: state ?? this.state,
      lga: lga ?? this.lga,
      isNegotiable: isNegotiable ?? this.isNegotiable,
      expiryDate: expiryDate ?? this.expiryDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      views: views ?? this.views,
      inquiries: inquiries ?? this.inquiries,
    );
  }

  // Helper to get formatted price
  String get formattedPrice {
    return '₦${price.toStringAsFixed(2)} / $priceUnit';
  }

  // Helper to check if listing is still valid
  bool get isValid {
    if (status != ListingStatus.active) return false;
    if (expiryDate != null && expiryDate!.isBefore(DateTime.now())) return false;
    return true;
  }
}
