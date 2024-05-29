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
  Club club;
  bool isPublic;

  PadelMatch(
      {required this.date,
      this.duration = 90,
      required this.owner,
      required this.club,
      this.isPublic = false});

  @override
  String toString() {
    return "{ Date: ${date.day}/${date.month}/${date.year}, Duration: $duration, Owner: ${owner.email}}";
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'date':
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:00",
      'duration': duration,
      'owner': owner.email
    };
  }

  @override
  factory PadelMatch.fromJson(Map<String, dynamic> json) {
    return PadelMatch(
        date: DateTime.parse(json['date']),
        duration: json['duration'],
        owner: json['owner'],
        club: json['club']);
  }
}
