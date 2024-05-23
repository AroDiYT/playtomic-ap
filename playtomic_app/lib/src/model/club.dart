import 'package:playtomic_app/src/model/user.dart';

class Club {
  String id;
  String image;
  Map<String, dynamic> location;
  String name;
  Map<String, double> geo;
  List<PadelMatch> matches = [];

  Club(
      {required this.id,
      required this.name,
      required this.image,
      required this.location,
      this.geo = const {"lat": 0.0, "lng": 0.0}});
}

class PadelMatch {
  DateTime date;
  int duration;
  AppUser owner;

  PadelMatch({required this.date, this.duration = 90, required this.owner});

  @override
  String toString() {
    return "{ Date: ${date.day}/${date.month}/${date.year}, Duration: $duration, Owner: ${owner.name}}";
  }

  @override
  Map<String, dynamic> toJson() {
    return {'date': date, 'duration': duration, 'owner': owner.name};
  }
}
