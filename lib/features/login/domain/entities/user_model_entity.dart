import 'package:equatable/equatable.dart';

class UserModelEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String role;
  final String? photo;
  final List<dynamic>? wishlist;
  final List<dynamic>? addresses;
  final String? createdAt;

  const UserModelEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.role,
    this.photo,
    this.wishlist,
    this.addresses,
    this.createdAt,
  });

  // Computed property للاسم الكامل
  String get fullName => '$firstName $lastName';

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    email,
    phone,
    role,
    photo,
    wishlist,
    addresses,
    createdAt,
  ];
}
