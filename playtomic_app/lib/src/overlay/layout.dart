import 'package:flutter/material.dart';
import 'package:playtomic_app/src/pages/play.dart';
import 'package:playtomic_app/src/pages/discover.dart';
import 'package:playtomic_app/src/pages/community.dart';
import 'package:playtomic_app/src/pages/Profile.dart';

import '../settings/settings_view.dart';

/// Displays a list of SampleItems.
class Layout extends StatelessWidget {
  const Layout({
    super.key,
  });

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
            toolbarHeight: 80,
            title: const Row(mainAxisSize: MainAxisSize.min, children: [
              ImageIcon(
                AssetImage("assets/images/PT_logo.png"),
                size: 40,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'P L A Y T O M I C',
                style: TextStyle(fontFamily: 'Naville'),
              ),
            ]),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.restorablePushNamed(
                        context, SettingsView.routeName);
                  },
                  icon: const Icon(Icons.chat)),
              IconButton(
                  onPressed: () {
                    Navigator.restorablePushNamed(
                        context, SettingsView.routeName);
                  },
                  icon: const Icon(Icons.notifications))
            ]),
        bottomNavigationBar: const TabBar(tabs: [
          Tab(
              text: "Play",
              icon: ImageIcon(
                AssetImage("assets/images/tennisball.png"),
                size: 40,
              )),
          Tab(
              text: "Discover",
              icon: ImageIcon(
                AssetImage("assets/images/radar.png"),
                size: 40,
              )),
          Tab(
              text: "Community",
              icon: ImageIcon(
                AssetImage("assets/images/home.png"),
                size: 40,
              )),
          Tab(
              text: "Profile",
              icon: ImageIcon(
                AssetImage("assets/images/profile.png"),
                size: 40,
              ))
        ]),
        body: const TabBarView(
          children: [Play(), Discover(), Community(), Profile()],
        ),
      ),
    );
  }
}
