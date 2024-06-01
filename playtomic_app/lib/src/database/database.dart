import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:playtomic_app/src/model/club.dart';
import 'package:playtomic_app/src/model/match.dart';
import 'package:playtomic_app/src/model/user.dart';

class Database {
  var firestore_db = FirebaseFirestore.instance;
  var auth_db = FirebaseAuth.instance;
  Logger logger;

  Database(this.logger);

  // TODO: Finish this method
  /// Gets a [AppUser] from the database
  Future<AppUser> loadUser(String id) async {
    logger.d("Database: Loading User");
    var snapshot =
        await firestore_db.collection('users').doc(id).snapshots().first;

    final uData = snapshot.data() as Map<String, dynamic>;

    return AppUser(
        email: uData['email'],
        name: uData['name'],
        tel: uData['tel'],
        preferences: Map<String, int>.from(uData['preferences']));
  }

  /// Creates a given [AppUser] in the database.
  /// If the user already exists in the database, their record will be overwritten.
  Future<void> createUser(AppUser user) async {
    try {
      firestore_db.collection('users').doc(user.email).snapshots().first;
      logger.e("Database: User already exists");
    } catch (e) {
      logger.d("Database: User doesn't exist yet. Creating database entry...");
      firestore_db.collection('users').doc(user.email).set(<String, dynamic>{});
    }
  }

  /// Updates the [fields] of a user with the given [email] (email) in the database.
  Future<void> updateUser(Map<String, dynamic> fields, String email) async {
    try {
      firestore_db.collection('users').doc(email).snapshots().first;
      logger.d("Database: User exists");
      firestore_db.collection('users').doc(email).update(fields);
    } catch (e) {
      logger.e("Database: User doesn't exist.");
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
      logger.d("Database: User exists");
      auth_db.currentUser!.reauthenticateWithCredential(credential);
      firestore_db.collection('users').doc(auth_db.currentUser!.email).delete();
    } catch (e) {}
  }

  /// Gets all [Club]s from the database
  Future<List<Club>> getClubs() async {
    var clubsSnapshot = await firestore_db.collection("clubs").get();
    var clubs = clubsSnapshot.docs.map((clubDocument) {
      var clubData = clubDocument.data();
      return Club(
          id: clubDocument.id,
          name: clubData["name"],
          image: clubData["image"],
          location: clubData["location"],
          geo: clubData["geo"]);
    }).toList();

    return clubs;
  }

  /// Gets all [Club]s from the database
  Future<Club> getClub(String clubId) async {
    logger.d("Database: Getting club with id: $clubId");

    var clubsSnapshot =
        await firestore_db.collection("clubs").doc(clubId).get();

    var club = clubsSnapshot.data()!;

    logger.d("Database: Found club with name: ${club["name"]}");

    return Club(
        id: clubId,
        name: club["name"],
        image: club["image"],
        location: club["location"],
        geo: club["geo"]);
  }

  Future<void> createClub(Club club) async {
    try {
      firestore_db.collection('clubs').doc(club.id).snapshots().first;
      logger.e("Database: Club already exists");
    } catch (e) {
      logger.d("Database: Club doesn't exist yet. Creating database entry...");
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
      logger.d("Database: Club exists");
      firestore_db.collection('users').doc(id).update(fields);
    } catch (e) {
      logger.e("Database: Club doesn't exist. \n${e.toString()}");
    }
  }

  Future<List<PadelMatch>> getAllMatches(String clubId) async {
    List<PadelMatch> matches = List.empty(growable: true);
    try {
      firestore_db
          .collection("matches")
          .where("clubId", isEqualTo: clubId)
          .get()
          .then((QuerySnapshot<Map<String, dynamic>> snap) => {
                snap.docs.forEach((matchDoc) async {
                  AppUser user = await loadUser(matchDoc.data()["ownerId"]);
                  Club club = await getClub(clubId);

                  matches.add(PadelMatch(
                      date: DateTime.parse(matchDoc.data()["date"] +
                          " " +
                          matchDoc.data()["time"]),
                      duration: matchDoc.data()["duration"],
                      owner: user,
                      club: club,
                      isPublic: matchDoc.data()["isPublic"],
                      team1: matchDoc.data()["team1"],
                      team2: matchDoc.data()["team2"]));
                })
              });
    } catch (e) {
      logger.e("Database: Error loading all matches.");
    }
    return matches;
  }

  Future<List<PadelMatch>> getMatchesByDate(
      String clubId, DateTime date) async {
    logger.d("Database: Getting matches from ${date.toString()}");

    try {
      Club club = await getClub(clubId);

      var snap = await firestore_db
          .collection("matches")
          .where("clubId", isEqualTo: clubId)
          .where("date",
              isEqualTo:
                  "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}")
          .get();

      var matches = await Future.wait(snap.docs.map((matchDoc) async {
        logger.d(
            "Database: Retrieved: {Date: ${matchDoc.data()["date"]} ${matchDoc.data()["time"]}, Duration: ${matchDoc.data()["duration"]}, Owner: ${matchDoc.data()["ownerId"]}}");

        AppUser user = await loadUser(matchDoc.data()["ownerId"]);

        logger.d("Database: OwnerId: ${user.email}");

        // Add the match to the list
        return PadelMatch(
            date: DateTime.parse(
                matchDoc.data()["date"] + " " + matchDoc.data()["time"]),
            duration: matchDoc.data()["duration"],
            owner: user,
            club: club,
            isPublic: matchDoc.data()["isPublic"],
            team1: matchDoc.data()["team1"],
            team2: matchDoc.data()["team2"]);
      }).toList());

      logger.d("Database: Matches: $matches");
      return matches;
    } catch (e) {
      logger.e("Database: Error loading matches by date. \n${e.toString()}");
      return List<PadelMatch>.empty();
    }
  }

  /// Retrieves all the matches where [user] is either the owner, a player of team 1 or a player of team 2.
  Future<List<PadelMatch>> getMatchesByUser(AppUser user) async {
    try {
      var snapshot = await firestore_db.collection("matches").get();

      var allMatches = snapshot.docs
          .where((snap) =>
              snap.data().containsValue(user.email) || // user is the owner
              snap.data()["team1"].contains(user.email) || // user is in team 1
              snap.data()["team2"].contains(user.email)) // user is in team 2
          .toList();

      var matches = await Future.wait(allMatches.map((matchDoc) async {
        logger.d(
            "Database: Retrieved: {Date: ${matchDoc.data()["date"]} ${matchDoc.data()["time"]}, Duration: ${matchDoc.data()["duration"]}, Owner: ${matchDoc.data()["ownerId"]}}");

        AppUser user = await loadUser(matchDoc.data()["ownerId"]);
        Club club = await getClub(matchDoc.data()["clubId"]);

        logger.d("Database: OwnerId: ${user.email}");

        // Add the match to the list
        return PadelMatch(
            date: DateTime.parse(
                matchDoc.data()["date"] + " " + matchDoc.data()["time"]),
            duration: matchDoc.data()["duration"],
            owner: user,
            club: club,
            isPublic: matchDoc.data()["isPublic"],
            team1: matchDoc.data()["team1"],
            team2: matchDoc.data()["team2"]);
      }).toList());

      logger.d("Database: Matches by user: $matches");
      return matches;
    } catch (e) {
      logger.e(
          "Database: Error loading matches where the user is owner. \n${e.toString()}");
      return List<PadelMatch>.empty();
    }
  }

  /// Retrieves all the matches from all the clubs that are open to join.
  Future<List<PadelMatch>> getOpenMatches() async {
    try {
      var snap = await firestore_db
          .collection("matches")
          .where("isPublic", isEqualTo: true)
          .get();

      var matches = await Future.wait(snap.docs.map((matchDoc) async {
        logger.d(
            "Database: Retrieved: {Date: ${matchDoc.data()["date"]} ${matchDoc.data()["time"]}, Duration: ${matchDoc.data()["duration"]}, Owner: ${matchDoc.data()["ownerId"]}}");

        AppUser user = await loadUser(matchDoc.data()["ownerId"]);
        Club club = await getClub(matchDoc.data()["clubId"]);

        logger.d("Database: OwnerId: ${user.email}");

        // Add the match to the list
        return PadelMatch(
            date: DateTime.parse(
                matchDoc.data()["date"] + " " + matchDoc.data()["time"]),
            duration: matchDoc.data()["duration"],
            owner: user,
            club: club,
            isPublic: matchDoc.data()["isPublic"],
            team1: matchDoc.data()["team1"],
            team2: matchDoc.data()["team2"]);
      }).toList());

      logger.d("Database: Open matches: $matches");
      return matches;
    } catch (e) {
      logger.e("Database: Error loading open matches. \n${e.toString()}");
      return List<PadelMatch>.empty();
    }
  }

  Future<void> createMatch(
    Club club,
    PadelMatch match,
  ) async {
    try {
      firestore_db.collection('matches').add({
        "date":
            "${match.date.year}-${match.date.month.toString().padLeft(2, '0')}-${match.date.day.toString().padLeft(2, '0')}",
        "time":
            "${match.date.hour.toString().padLeft(2, '0')}:${match.date.minute.toString().padLeft(2, '0')}:00",
        "duration": match.duration,
        "ownerId": match.owner.email,
        "clubId": club.id,
        "isPublic": match.isPublic,
        "team1": match.team1,
        "team2": match.team2
      });

      logger.d(
          "$this: Added the following ${(match.isPublic) ? "public" : "private"} match to the club \"${club.name}\": ${match.toString()}");
    } catch (e) {
      logger.e("Database: Could not add match to database.");
    }
  }
}
