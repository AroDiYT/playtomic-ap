import 'package:flutter/material.dart';
import 'package:playtomic_app/src/pages/play/play_content.dart';
import 'package:playtomic_app/src/settings/settings_view.dart';

class Play extends StatefulWidget {
  const Play({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 80,
          title: const Row(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: ImageIcon(
                AssetImage("assets/images/PT_logo.png"),
                size: 30,
              ),
            ),
            Text(
              'PLAYTOMIC',
              style: TextStyle(
                  fontFamily: 'Naville',
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold),
            ),
          ]),
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
                icon: const Icon(Icons.notifications_none_outlined))
          ]),
      body: const PlayContent(),
    );
  }
}
