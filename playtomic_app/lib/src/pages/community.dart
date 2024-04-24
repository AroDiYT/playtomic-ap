import 'package:flutter/material.dart';
import 'package:playtomic_app/src/settings/settings_view.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
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
          ]),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.person_add_alt_outlined)),
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
      body: Text("Community Page"),
    );
  }
}
