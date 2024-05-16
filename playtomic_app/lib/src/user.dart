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