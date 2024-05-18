import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:playtomic_app/src/pages/profile/edit_preferences.dart';
import 'package:playtomic_app/src/user.dart';

class ProfileActivities extends StatefulWidget {
  final AppUser user;
  final Logger logger = Logger(printer: SimplePrinter(printTime: true));

  ProfileActivities({super.key, required this.user});

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
          profilePreferences(preferences: widget.user.preferences),
        ],
      ),
    );
  }

  Widget profilePreferences({required Map<String, int> preferences}) {
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
              TextButton(
                onPressed: () {
                  widget.logger.d("Edit button pressed");
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (ctx, anim1, anim2) => EditPreferences(
                                user: widget.user,
                              )));
                  widget.logger.d("Going to EditPreferences page");
                },
                child: Text(
                  "Edit",
                  style: TextStyle(
                      color: Colors.blue.shade800, fontWeight: FontWeight.bold),
                ),
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

  Widget preference(
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
