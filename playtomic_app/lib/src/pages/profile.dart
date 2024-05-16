import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playtomic_app/src/pages/profile_content.dart';
import 'package:playtomic_app/src/settings/settings_view.dart';
// ignore: unused_import

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 80,
            centerTitle: true,
            title: Text(
              'Profile',
              style:
                  GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.restorablePushNamed(
                        context, SettingsView.routeName);
                  },
                  icon: const Icon(Icons.chat_bubble_outline)),
              IconButton(
                  onPressed: () {
                    Navigator.restorablePushNamed(
                        context, SettingsView.routeName);
                  },
                  icon: const Icon(
                    Icons.menu,
                    size: 26,
                  ))
            ]),
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user.email)
                .snapshots(),
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                final uData = snapshot.data!.data() as Map<String, dynamic>;

                return SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        Text("signed in as ${user.email!}"),
                        MaterialButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                            },
                            color: Colors.grey,
                            child: const Text("Sign Out")),

                        Column(
                          children: [
                            // Avatar and name:
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: GFAvatar(
                                    backgroundColor: Colors.indigo.shade900,
                                    child: Text(
                                      uData['name']
                                          .toString()
                                          .trim()
                                          .split(' ')
                                          .map((l) => l[0])
                                          .take(2)
                                          .join(),
                                      style: const TextStyle(
                                          letterSpacing: 3,
                                          color: Colors.white,
                                          fontSize: 20),
                                    ),

                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      uData['name'],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Voeg mijn locatie toe",
                                      style: TextStyle(
                                          color: Colors.blue.shade700,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            ),
                            // Wedstrijden, Volgers and Volgend:
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                      onPressed: () {},
                                      child: const Column(
                                        children: [
                                          Text(
                                            "0",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            "Wedstrijden",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const VerticalDivider(
                                      thickness: 1,
                                      color: Colors.grey,
                                    ),
                                    TextButton(
                                        onPressed: () {},
                                        child: const Column(
                                          children: [
                                            Text(
                                              "0",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                            Text("Volgers",
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          ],
                                        )),
                                    const VerticalDivider(
                                      thickness: 1,
                                      color: Colors.grey,
                                    ),
                                    TextButton(
                                        onPressed: () {},
                                        child: const Column(
                                          children: [
                                            Text(
                                              "0",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                            Text("Volgend",
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            // Edit Profile and Get Premium:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width: 180,
                                  child: GFButton(
                                      onPressed: () {},
                                      color: Colors.indigo.shade900,
                                      shape: GFButtonShape.pills,
                                      type: GFButtonType.outline,
                                      child: const Text("Profiel Bewerken")),
                                ),
                                SizedBox(
                                  width: 180,
                                  child: GFButton(
                                      onPressed: () {},
                                      color: Colors.indigo.shade900,
                                      textColor: Colors.amber,
                                      shape: GFButtonShape.pills,
                                      child: const Text("Ga voor Premium")),
                                )
                              ],
                            ),
                            // Activiteiten and Posts
                            const ProfileContent()
                          ],
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(child: Text('Loading..'));
              }
            }));
  }
}
