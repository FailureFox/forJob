import 'dart:convert';

class GeoModel {
  double lat;
  double lng;
  GeoModel({
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toMap() {
    return {
      'lat': lat.toString(),
      'lng': lng.toString(),
    };
  }

  factory GeoModel.fromMap(Map<String, dynamic> map) {
    return GeoModel(
      lat: double.parse(map['lat']),
      lng: double.parse(map['lng']),
    );
  }

  String toJson() => json.encode(toMap());
}
