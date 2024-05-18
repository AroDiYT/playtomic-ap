import 'dart:collection';

class AppUser {
  // if you add a field, update the toMap() method
  String email;
  String name;
  String tel;
  bool hasPremium = false;
  Map<String, int> preferences = {
    "favTime": -1,
    "hand": -1,
    "position": -1,
    "type": -1,
  };
  int gender = -1;
  DateTime dateOfBirth = DateTime(0);
  String bio = "";
  String location = "";
  LinkedHashMap<String, bool> interests = LinkedHashMap.from({
    "Ontdek de gemeenschap": false,
    "Concurreren met anderen": false,
    "Speel met vrienden": false,
    "Mijn speelniveau kennen": false,
    "Mijn vooruitgang bijhouden": false,
    "Reserveer een baan": false,
    "Zoek mensen om mee te spelen": false,
  });
  String avatarPic = "";

  AppUser({required this.email, required this.name, required this.tel});

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
