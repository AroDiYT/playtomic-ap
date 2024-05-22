class Club {
  String image;
  Map<String, dynamic> location;
  String name;
  Map<String, double> geo;

  Club(
      {required this.name,
      required this.image,
      required this.location,
      this.geo = const {"lat": 0.0, "lng": 0.0}});
}
