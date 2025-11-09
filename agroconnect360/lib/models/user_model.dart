enum UserType {
  farmer,
  buyer,
  inputDealer,
  serviceProvider,
}

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final UserType userType;
  final String? profileImageUrl;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isVerified;
  final String? address;
  final String? state;
  final String? lga; // Local Government Area

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.userType,
    this.profileImageUrl,
    required this.createdAt,
    this.updatedAt,
    this.isVerified = false,
    this.address,
    this.state,
    this.lga,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      userType: UserType.values.firstWhere(
        (e) => e.toString() == 'UserType.${json['userType']}',
        orElse: () => UserType.farmer,
      ),
      profileImageUrl: json['profileImageUrl'],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      isVerified: json['isVerified'] ?? false,
      address: json['address'],
      state: json['state'],
      lga: json['lga'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'userType': userType.toString().split('.').last,
      'profileImageUrl': profileImageUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'isVerified': isVerified,
      'address': address,
      'state': state,
      'lga': lga,
    };
  }

  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phoneNumber,
    UserType? userType,
    String? profileImageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isVerified,
    String? address,
    String? state,
    String? lga,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userType: userType ?? this.userType,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isVerified: isVerified ?? this.isVerified,
      address: address ?? this.address,
      state: state ?? this.state,
      lga: lga ?? this.lga,
    );
  }
}
