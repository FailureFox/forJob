import 'package:test_project/models/address_model.dart';

import 'company_model.dart';

class UserModel {
  int id;
  String name;
  String userName;
  String email;
  AddressModel address;
  String phone;
  String website;
  Company company;
  String avatarPath;
  static const _assetPath = 'assets/avatars/avataaars';
  UserModel({
    required this.id,
    required this.name,
    required this.userName,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
    required this.avatarPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'userName': userName,
      'email': email,
      'address': address.toMap(),
      'phone': phone,
      'website': website,
      'company': company.toMap(),
      'avatar': avatarPath,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      userName: map['userName'] ?? '',
      email: map['email'] ?? '',
      address: AddressModel.fromMap(map['address']),
      phone: map['phone'] ?? '',
      website: map['website'] ?? '',
      company: Company.fromMap(map['company']),
      avatarPath: _assetPath + '(${map['id']}).png',
    );
  }
}
