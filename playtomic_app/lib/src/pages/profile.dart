import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playtomic_app/src/settings/settings_view.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
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
        body: Center(
          child: Column(
            children: [
              const Text("Profile Page"),
              Text("signed in as ${user.email!}"),
              MaterialButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  color: Colors.grey,
                  child: const Text("Sign Out")),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: GFAvatar(
                      backgroundColor: Colors.blue.shade900,
                      child: const Text(
                        "KV",
                        style: TextStyle(
                            letterSpacing: 3,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  const Text(
                    "Koen Van Aken",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
