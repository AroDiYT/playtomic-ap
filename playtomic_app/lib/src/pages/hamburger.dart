import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:playtomic_app/src/user.dart';

class Hamburger extends StatefulWidget {
  final AppUser user;

  const Hamburger({Key? key, required this.user}) : super(key: key);

  @override
  _HamburgerState createState() => _HamburgerState();
}

class _HamburgerState extends State<Hamburger> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close))),
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
                        letterSpacing: 3, color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
            Text("signed in as ${widget.user.email!}"),
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
    );
  }
}
