import 'package:flutter/material.dart';
import 'package:playtomic_app/src/user.dart';

class ProfileActivities extends StatefulWidget {
  AppUser user;

  ProfileActivities({super.key, required this.user});

  @override
  // ignore: library_private_types_in_public_api
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
}

class ProfilePreferences extends StatelessWidget {
  final Map<String, int> preferences;

  ProfilePreferences({super.key, required this.preferences});

  final hand = ["Rechtshandig", "Linkshandig", "Beide"];
  final position = ["Backhand", "Forehand", "Beide helften"];
  final gameType = ["Concurrerend", "Vriendschappelijk", "Beide"];
  final time = ["Ochtend", "Middag", "Avond", "De hele dag"];

  @override
  Widget build(BuildContext context) {
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
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
              color: Colors.white),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                const Text(
                  "👋",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Beste hand"),
                    const SizedBox(
                      height: 5,
                    ),
                    if (preferences["hand"] != -1 &&
                        preferences["hand"] != null)
                      Text(hand[preferences["hand"]!])
                    else
                      const Text("Onbekend")
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
              color: Colors.white),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                const Text(
                  "📍",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Baanpositie"),
                    const SizedBox(
                      height: 5,
                    ),
                    if (preferences["position"] != -1 &&
                        preferences["position"] != null)
                      Text(position[preferences["position"]!])
                    else
                      const Text("Onbekend")
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const Text(
                  "🥇",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Type partij"),
                    const SizedBox(
                      height: 5,
                    ),
                    if (preferences["type"] != -1 &&
                        preferences["type"] != null)
                      Text(gameType[preferences["type"]!])
                    else
                      const Text("Onbekend")
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const Text(
                  "🌄",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Favoriete tijd om te spelen"),
                    const SizedBox(
                      height: 5,
                    ),
                    if (preferences["time"] != -1 &&
                        preferences["time"] != null)
                      Text(time[preferences["time"]!])
                    else
                      const Text("Onbekend")
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
