import 'package:flutter/material.dart';
import 'package:playtomic_app/src/pages/Home.dart';
import 'package:playtomic_app/src/pages/discover.dart';
import 'package:playtomic_app/src/pages/community.dart';
import 'package:playtomic_app/src/pages/Profile.dart';

import '../settings/settings_view.dart';

// test

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
            title: const Text('playtomic'),
            actions: [IconButton(onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            }, icon: const Icon(Icons.settings))],
            bottom: const TabBar(
              
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
                Tab(icon: Icon(Icons.access_time_sharp))
              ],
            )
          ),
          body: const TabBarView(
            children: [
              Home(),
              Discover(),
              Community(),
              Profile()
            ],
          ),
        ),
      );
        }
}
