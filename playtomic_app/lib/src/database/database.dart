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
    logger.d("$this: Loading User");
    var snapshot =
        await firestore_db.collection('users').doc(id).snapshots().first;

    final uData = snapshot.data() as Map<String, dynamic>;

    return AppUser(
        email: uData['email'], name: uData['name'], tel: uData['tel']);
  }

  /// Creates a given [AppUser] in the database.
  /// If the user already exists in the database, their record will be overwritten.
  Future<void> createUser(AppUser user) async {
    try {
      firestore_db.collection('users').doc(user.email).snapshots().first;
      logger.e("$this: User already exists");
    } catch (e) {
      logger.d("$this: User doesn't exist yet. Creating database entry...");
      firestore_db.collection('users').doc(user.email).set(<String, dynamic>{});
    }
  }

  /// Updates the [fields] of a user with the given [email] (email) in the database.
  Future<void> updateUser(Map<String, dynamic> fields, String email) async {
    try {
      firestore_db.collection('users').doc(email).snapshots().first;
      logger.d("$this: User exists");
      firestore_db.collection('users').doc(email).update(fields);
    } catch (e) {
      logger.e("$this: User doesn't exist.");
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
      logger.d("$this: User exists");
      auth_db.currentUser!.reauthenticateWithCredential(credential);
      firestore_db.collection('users').doc(auth_db.currentUser!.email).delete();
    } catch (e) {}
  }

  /// Gets a [Club] from the database
  Future<List<Club>> getClubs() async {
    var clubsSnapshot = await firestore_db.collection("clubs").get();
    var clubs = clubsSnapshot.docs.map((clubDocument) {
      var clubData = clubDocument.data();
      return Club(
          id: clubDocument.id,
          name: clubData["name"],
          image: clubData["image"],
          location: clubData["location"]);
    }).toList();

    return clubs;
  }

  Future<void> createClub(Club club) async {
    try {
      firestore_db.collection('clubs').doc(club.id).snapshots().first;
      logger.e("Club already exists");
    } catch (e) {
      logger.d("Club doesn't exist yet. Creating database entry...");
      firestore_db.collection('clubs').add({
        "name": club.name,
        "image": club.image,
        "location": club.location,
      });
    }
  }

  /// Updates the [fields] of a user with the given [id] (email) in the database.
  Future<void> updateClub(Map<String, dynamic> fields, String id) async {
    try {
      firestore_db.collection('users').doc(id).snapshots().first;
      logger.d("Club exists");
      firestore_db.collection('users').doc(id).update(fields);
    } catch (e) {
      logger.e("Club doesn't exist. \n${e.toString()}");
    }
  }

  Future<List<PadelMatch>> getAllMatches(String clubId) async {
    List<PadelMatch> matches = List.empty(growable: true);
    try {
      firestore_db
          .collection("clubs")
          .doc(clubId)
          .collection("matches")
          .get()
          .then((QuerySnapshot<Map<String, dynamic>> snap) => {
                snap.docs.forEach((matchDoc) async {
                  AppUser user = await loadUser(matchDoc.data()["ownerId"]);
                  matches.add(PadelMatch(
                      date: DateTime.parse(matchDoc.data()["date"] +
                          " " +
                          matchDoc.data()["time"]),
                      duration: matchDoc.data()["duration"],
                      owner: user));
                })
              });
    } catch (e) {
      logger.e("$this: Error loading all matches.");
    }
    return matches;
  }

  Future<List<PadelMatch>> getMatchesByDate(
      String clubId, DateTime date) async {
    logger.d("$this: Getting matches from ${date.toString()}");

    try {
      var snap = await firestore_db
          .collection("clubs")
          .doc(clubId)
          .collection("matches")
          .where("date",
              isEqualTo:
                  "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}")
          .get();

      var matches = await Future.wait(snap.docs.map((matchDoc) async {
        logger.d(
            "$this: Retrieved: {Date: ${matchDoc.data()["date"]} ${matchDoc.data()["time"]}, Duration: ${matchDoc.data()["duration"]}, Owner: ${matchDoc.data()["ownerId"]}}");

        AppUser user = await loadUser(matchDoc.data()["ownerId"]);

        logger.d("$this: OwnerId: ${user.email}");
        return PadelMatch(
            date: DateTime.parse(
                matchDoc.data()["date"] + " " + matchDoc.data()["time"]),
            duration: matchDoc.data()["duration"],
            owner: user);
      }).toList());

      logger.d("$this: Matches: $matches");
      return matches;
    } catch (e) {
      logger.e("$this: Error loading matches. \n${e.toString()}");
      return List<PadelMatch>.empty();
    }
  }

  Future<void> createMatch(Club club, PadelMatch match) async {
    try {
      firestore_db.collection('clubs').doc(club.id).collection('matches').add({
        "date":
            "${match.date.year}-${match.date.month.toString().padLeft(2, '0')}-${match.date.day.toString().padLeft(2, '0')}",
        "time":
            "${match.date.hour.toString().padLeft(2, '0')}:${match.date.minute.toString().padLeft(2, '0')}:00",
        "duration": match.duration,
        "ownerId": match.owner.email,
      });
      logger.d(
          "$this: Added the following match to the club \"${club.name}\": ${match.toString()}");
    } catch (e) {}
  }
}
