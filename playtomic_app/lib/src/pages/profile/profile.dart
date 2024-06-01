import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:playtomic_app/src/pages/profile/hamburger.dart';
import 'package:playtomic_app/src/pages/profile/profile_activities.dart';
import 'package:playtomic_app/src/pages/profile/profile_posts.dart';
import 'package:playtomic_app/src/settings/settings_view.dart';
import 'package:playtomic_app/src/model/user.dart';
// ignore: unused_import

class Profile extends StatefulWidget {
  Profile({super.key});
  final Logger logger = Logger(printer: SimplePrinter(printTime: true));

  @override
  // ignore: library_private_types_in_public_api
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(text: "Activiteiten"),
    Tab(text: "Posts"),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<AppUser> getUser() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .snapshots()
        .first;

    final uData = snapshot.data() as Map<String, dynamic>;

    return AppUser(
        email: uData['email'],
        name: uData['name'],
        tel: uData['tel'],
        preferences: Map<String, int>.from(uData['preferences']));
  }

  Future<void> updateUser(AppUser user) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        // Using merge will preserve fields not included in the AppUser data model.
        // This is good in cases we dont want new fields added via backend to be overwritten.
        .set(user.toMap(), SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUser(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            var user = snapshot.data!;

            return Scaffold(
              appBar: AppBar(
                  scrolledUnderElevation: 0,
                  toolbarHeight: 50,
                  centerTitle: true,
                  title: Text(
                    'Profile',
                    style: GoogleFonts.roboto(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  actions: [chatsBtn(context), hamburgerBtn(context, user)]),
              body: NestedScrollView(
                headerSliverBuilder: (ctx, val) => [
                  SliverList.list(children: [
                    Column(
                      children: [
                        // Avatar and name:
                        heading(user.name),
                        // Wedstrijden, Volgers and Volgend:
                        stats(),
                        // Edit Profile and Get Premium:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [editProfileBtn(), getPremiumBtn()],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ]),
                  SliverAppBar(
                    scrolledUnderElevation: 0,
                    pinned: true,
                    toolbarHeight: 30,
                    title: SizedBox(
                      height: 30,
                      child: TabBar(
                          controller: _tabController,
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelColor: Colors.indigo.shade900,
                          indicatorColor: Colors.indigo.shade900,
                          splashFactory: NoSplash.splashFactory,
                          tabs: myTabs),
                    ),
                  )
                ],
                body: TabBarView(controller: _tabController, children: [
                  ProfileActivities(user: user),
                  const ProfilePosts(),
                ]),
              ),
            );
          } else {
            return const Text("Loading");
          }
        });
  }

  SizedBox getPremiumBtn() {
    return SizedBox(
      width: 180,
      child: GFButton(
          onPressed: () {},
          color: Colors.indigo.shade900,
          textColor: Colors.amber,
          shape: GFButtonShape.pills,
          child: const Text("Ga voor Premium")),
    );
  }

  SizedBox editProfileBtn() {
    return SizedBox(
      width: 180,
      child: GFButton(
          onPressed: () {},
          color: Colors.indigo.shade900,
          shape: GFButtonShape.pills,
          type: GFButtonType.outline,
          child: const Text("Profiel Bewerken")),
    );
  }

  Padding stats() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {},
              child: const Column(
                children: [
                  Text(
                    "0",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Text(
                    "Wedstrijden",
                    style: TextStyle(color: Colors.black),
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
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Text("Volgers", style: TextStyle(color: Colors.black)),
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
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Text("Volgend", style: TextStyle(color: Colors.black)),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Row heading(String name) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: GFAvatar(
            backgroundColor: Colors.indigo.shade900,
            child: Text(
              name.toString().trim().split(' ').map((l) => l[0]).take(2).join(),
              style: const TextStyle(
                  letterSpacing: 3, color: Colors.white, fontSize: 20),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
    );
  }

  IconButton hamburgerBtn(BuildContext context, AppUser user) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).push(PageRouteBuilder(
            opaque: false,
            pageBuilder: (ctx, __, ___) => Hamburger(user: user),
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
