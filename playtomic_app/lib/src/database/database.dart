import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:playtomic_app/src/model/club.dart';
import 'package:playtomic_app/src/model/user.dart';

class Database {
  var firestore_db = FirebaseFirestore.instance;
  var auth_db = FirebaseAuth.instance;
  Logger logger;

  Database(this.logger);

  // TODO: Finish this method
  /// Gets a [AppUser] from the database
  Future<AppUser> loadUser(String id) async {
    var snapshot = await firestore_db
        .collection('users')
        .doc(auth_db.currentUser!.email)
        .snapshots()
        .first;

    final uData = snapshot.data() as Map<String, dynamic>;

    return AppUser(
        email: uData['email'], name: uData['name'], tel: uData['tel']);
  }

  /// Creates a given [AppUser] in the database.
  /// If the user already exists in the database, their record will be overwritten.
  Future<void> createUser(AppUser user) async {
    try {
      firestore_db.collection('users').doc(user.email).snapshots().first;
      logger.e("User already exists");
    } catch (e) {
      logger.d("User doesn't exist yet. Creating database entry...");
      firestore_db.collection('users').doc(user.email).set(<String, dynamic>{});
    }
  }

  /// Updates the [fields] of a user with the given [email] (email) in the database.
  Future<void> updateUser(Map<String, dynamic> fields, String email) async {
    try {
      firestore_db.collection('users').doc(email).snapshots().first;
      logger.d("User exists");
      firestore_db.collection('users').doc(email).update(fields);
    } catch (e) {
      logger.e("User doesn't exist.");
    }
  }

  /// Deletes the current [AppUser] from the database.
  /// The password from the user is required.
  Future<void> deleteCurrentUser(AuthCredential credential) async {
    try {
      firestore_db
          .collection('users')
          .doc(auth_db.currentUser!.email)
          .snapshots()
          .first;
      logger.d("User exists");
      auth_db.currentUser!.reauthenticateWithCredential(credential);
      firestore_db.collection('users').doc(auth_db.currentUser!.email).delete();
    } catch (e) {}
  }

  Future<List<Club>> getClubs() async {
    var clubsSnapshot = await firestore_db.collection("clubs").get();
    var clubs = clubsSnapshot.docs.map((clubDocument) {
      var clubData = clubDocument.data();
      return Club(
          name: clubData["name"],
          image: clubData["image"],
          location: clubData["location"]);
    }).toList();

    return clubs;
  }
}
