import 'package:flutter/material.dart';
import 'package:playtomic_app/src/user.dart';

class ProfileActivities extends StatefulWidget {
  final AppUser user;

  const ProfileActivities({super.key, required this.user});

  @override
  _ProfileActivitiesState createState() => _ProfileActivitiesState();
}

class _ProfileActivitiesState extends State<ProfileActivities> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ProfilePreferences(preferences: widget.user.preferences),
        ],
      ),
    );
  }

  Widget ProfilePreferences({required Map<String, int> preferences}) {
    final hand = ["Rechtshandig", "Linkshandig", "Beide"];
    final position = ["Backhand", "Forehand", "Beide helften"];
    final gameType = ["Concurrerend", "Vriendschappelijk", "Beide"];
    final time = ["Ochtend", "Middag", "Avond", "De hele dag"];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Preferences",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Edit",
                style: TextStyle(
                    color: Colors.blue.shade800, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        preference(preferences['hand'], hand, "👋", "Beste hand"),
        const SizedBox(
          height: 10,
        ),
        preference(preferences["position"], position, "📍", "Baanpositie"),
        const SizedBox(
          height: 10,
        ),
        preference(preferences["type"], gameType, "🥇", "Type partij"),
        const SizedBox(
          height: 10,
        ),
        preference(
            preferences["time"], time, "🌄", "Favoriete tijd om te spelen"),
      ],
    );
  }

  Container preference(
      int? choice, List<String> choices, String emoji, String preferenceTitle) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(preferenceTitle),
                const SizedBox(
                  height: 5,
                ),
                if (choice != -1 && choice != null)
                  Text(choices[choice])
                else
                  const Text("Onbekend")
              ],
            )
          ],
        ),
      ),
    );
  }
}
