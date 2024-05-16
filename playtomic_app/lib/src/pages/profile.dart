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
            actions: [chatsBtn(context), hamburgerBtn(context)]),
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

  IconButton hamburgerBtn(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).push(PageRouteBuilder(
            opaque: false,
            pageBuilder: (ctx, __, ___) => Scaffold(
              appBar: AppBar(
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close))),
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text("Koen"), Text("Standaard account")],
                        ),
                        GFAvatar(
                          backgroundColor: Colors.indigo.shade900,
                          child: const Text(
                            "K",
                            style: TextStyle(
                                letterSpacing: 3,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Text("signed in as ${user.email!}"),
                    MaterialButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pop(context);
                        },
                        color: Colors.grey,
                        child: const Text("Sign Out")),
                  ],
                ),
              ),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.ease;

              final tween = Tween(begin: begin, end: end);
              final curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: curve,
              );

              return SlideTransition(
                  position: tween.animate(curvedAnimation), child: child);
            },
          ));
        },
        icon: const Icon(
          Icons.menu,
          size: 26,
        ));
  }

  IconButton chatsBtn(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.restorablePushNamed(context, SettingsView.routeName);
        },
        icon: const Icon(Icons.chat_bubble_outline));
  }
}
