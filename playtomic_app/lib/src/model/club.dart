import 'package:cloud_firestore/cloud_firestore.dart';

class Club {
  String id;
  String image;
  Map<String, dynamic> location;
  String name;
  GeoPoint geo;

  Club(
      {required this.id,
      required this.name,
      required this.image,
      required this.location,
      this.geo = const GeoPoint(0, 0)});
}
