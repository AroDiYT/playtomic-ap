import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


Future<void> createEmptyMatch(String clubLocation) async {
    
    User? user = FirebaseAuth.instance.currentUser;
    
    await FirebaseFirestore.instance.collection('matches').add({
      'type': 'pending',  
      'players': [user?.email], 
      'clubLocation': clubLocation,
      'createdBy': user?.email,
      'createdAt': FieldValue.serverTimestamp(),
      'scoreTeam1': 0, 
      'scoreTeam2': 0, 
    });
}


Future<void> addPlayerToMatch(String matchId, String playerEmail) async {
  try {
    DocumentReference matchRef = FirebaseFirestore.instance.collection('matches').doc(matchId);
    DocumentSnapshot matchSnapshot = await matchRef.get();

    if (!matchSnapshot.exists) {
      return;
    }

    Map<String, dynamic> matchData = matchSnapshot.data() as Map<String, dynamic>;
    List<dynamic> players = matchData['players'] ?? [];

    
    if (!players.contains(playerEmail)) {
      players.add(playerEmail);
      matchRef.update({'players': players});

      
      if (players.length == 2 && matchData['type'] == 'pending') {
        matchRef.update({'type': '1V1'});
      } else if (players.length == 4) {
        matchRef.update({'type': '2V2'});
      }

    } else {
    }
  } catch (e) {
    print(e.toString());
  }
}


Future<void> changeMatchType(String matchId, String newMatchType) async {
  try {
    
    User? user = FirebaseAuth.instance.currentUser;

    DocumentReference matchRef = FirebaseFirestore.instance.collection('matches').doc(matchId);
    DocumentSnapshot matchSnapshot = await matchRef.get();

    if (!matchSnapshot.exists) {
      return;
    }

    Map<String, dynamic> matchData = matchSnapshot.data() as Map<String, dynamic>;

    
    if (matchData['createdBy'] != user?.email) {
      return;
    }

    
    await matchRef.update({'type': newMatchType});
  } catch (e) {
    print(e.toString());
  }
}
