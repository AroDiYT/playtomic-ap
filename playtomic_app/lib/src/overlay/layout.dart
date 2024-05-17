import 'package:flutter/material.dart';
import 'package:playtomic_app/src/pages/play/play.dart';
import 'package:playtomic_app/src/pages/discover.dart';
import 'package:playtomic_app/src/pages/community.dart';
import 'package:playtomic_app/src/pages/profile/profile.dart';

/// Displays a list of SampleItems.
class Layout extends StatefulWidget {
  const Layout({
    super.key,
  });

  static const routeName = '/';

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int index = 0;

  final screens = [
    const Play(),
    const Discover(),
    const Community(),
    const Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
          ),
        ]),
        child: BottomNavigationBar(
          fixedColor: Colors.black,
          backgroundColor: Colors.grey.shade100,
          currentIndex: index,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              this.index = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/tennisball.png"),
                size: 30,
              ),
              label: "Play",
              activeIcon: ImageIcon(
                AssetImage("assets/images/tennisball_selected.png"),
                size: 30,
              ),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/radar.png"),
                size: 30,
              ),
              label: "Discover",
              activeIcon: ImageIcon(
                AssetImage("assets/images/radar.png"),
                size: 30,
              ),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/home.png"),
                size: 30,
              ),
              label: "Community",
              activeIcon: ImageIcon(
                AssetImage("assets/images/home_selected.png"),
                size: 30,
              ),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/profile.png"),
                size: 30,
              ),
              label: "Profile",
              activeIcon: ImageIcon(
                AssetImage("assets/images/profile_selected.png"),
                size: 30,
              ),
            )
          ],
        ),
      ),
      body: SafeArea(child: Center(child: screens[index])),
    );
  }
}
