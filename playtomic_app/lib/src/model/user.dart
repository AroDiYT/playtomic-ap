class AppUser {
  // if you add a field, update the toMap() method
  String email;
  String name;
  String tel;
  bool hasPremium;
  Map<String, int> preferences;
  int gender;
  String dateOfBirth;
  String bio;
  Map<String, double> location;
  Map<String, bool> interests;
  String avatarPic;

  AppUser(
      {required this.email,
      required this.name,
      required this.tel,
      this.hasPremium = false,
      this.preferences = const <String, int>{
        "favTime": -1,
        "hand": -1,
        "position": -1,
        "type": -1,
      },
      this.gender = -1,
      this.dateOfBirth = "",
      this.bio = "",
      this.location = const {"lat": 0, "lng": 0},
      this.interests = const <String, bool>{
        "Ontdek de gemeenschap": false,
        "Concurreren met anderen": false,
        "Speel met vrienden": false,
        "Mijn speelniveau kennen": false,
        "Mijn vooruitgang bijhouden": false,
        "Reserveer een baan": false,
        "Zoek mensen om mee te spelen": false,
      },
      this.avatarPic = ""});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'tel': tel,
      'hasPremium': hasPremium,
      'preferences': preferences
    };
  }
}
