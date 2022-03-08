import 'dart:convert';

import 'package:test_project/models/geo_model.dart';

class AddressModel {
  String street;
  String suite;
  String city;
  String zipcode;
  GeoModel geo;
  AddressModel({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'suite': suite,
      'city': city,
      'zipcode': zipcode,
      'geo': geo.toMap(),
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      street: map['street'] ?? '',
      suite: map['suite'] ?? '',
      city: map['city'] ?? '',
      zipcode: map['zipcode'] ?? '',
      geo: GeoModel.fromMap(map['geo']),
    );
  }

  String toJson() => json.encode(toMap());
}
