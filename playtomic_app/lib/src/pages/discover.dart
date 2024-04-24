import 'package:flutter/material.dart';
import 'package:playtomic_app/src/settings/settings_view.dart';

class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
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
                onPressed: () {
                  Navigator.restorablePushNamed(
                      context, SettingsView.routeName);
                },
                icon: const Icon(Icons.chat_bubble_outline)),
          ]),
      body: Text("Discover Page"),
    );
  }
}
