import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/getwidget.dart';

class ProfileActivities extends StatefulWidget {
  const ProfileActivities({Key? key}) : super(key: key);

  @override
  _ProfileActivitiesState createState() => _ProfileActivitiesState();
}

class _ProfileActivitiesState extends State<ProfileActivities> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          ProfilePreferences(),
        ],
      ),
    );
  }
}

class ProfilePreferences extends StatelessWidget {
  const ProfilePreferences({
    super.key,
  });

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
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Text(
                  "👋",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Beste hand"),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Rechtshandig")
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
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Text(
                  "📍",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Baanpositie"),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Forehand")
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
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Text(
                  "🥇",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Type partij"),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Concurrerend")
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
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Text(
                  "🌄",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Favoriete tijd om te spelen"),
                    SizedBox(
                      height: 5,
                    ),
                    Text("'s Morgens'")
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
