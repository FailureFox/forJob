import 'dart:convert';

import 'package:test_project/domain/user_domain.dart';
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
  List<AvatarModel> avatars;
  UserModel({
    required this.id,
    required this.name,
    required this.userName,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
    required this.avatars,
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
      'avatar': avatars.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(
      Map<String, dynamic> map, List<AvatarModel> avatars) {
    return UserModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      userName: map['userName'] ?? '',
      email: map['email'] ?? '',
      address: AddressModel.fromMap(map['address']),
      phone: map['phone'] ?? '',
      website: map['website'] ?? '',
      company: Company.fromMap(map['company']),
      avatars: avatars,
    );
  }
}
