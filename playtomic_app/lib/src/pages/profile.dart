import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playtomic_app/src/pages/profile_activities.dart';
import 'package:playtomic_app/src/pages/profile_content.dart';
import 'package:playtomic_app/src/settings/settings_view.dart';
import 'package:playtomic_app/src/user.dart';
// ignore: unused_import

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<AppUser> getUser() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .snapshots()
        .first;

    final uData = snapshot.data() as Map<String, dynamic>;

    return AppUser(
        email: uData['email'], name: uData['name'], tel: uData['tel']);
  }

  updateUser(AppUser user) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .set(user.toMap());
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
                    toolbarHeight: 80,
                    centerTitle: true,
                    title: Text(
                      'Profile',
                      style: GoogleFonts.roboto(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    actions: [chatsBtn(context), hamburgerBtn(context, user)]),
                body: CustomScrollView(
                  slivers: [
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
                        ],
                      ),
                    ]),
                    SliverAppBar(
                      scrolledUnderElevation: 0,
                      pinned: true,
                      title: DefaultTabController(
                        length: 2,
                        child: TabBar(
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: Colors.indigo.shade900,
                            indicatorColor: Colors.indigo.shade900,
                            splashFactory: NoSplash.splashFactory,
                            tabs: const [
                              Tab(text: "Activiteiten"),
                              Tab(text: "Posts"),
                            ]),
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      SizedBox(
                        //Add this to give height
                        height:
                            1000, //TODO: Find better solution to make this scrollable
                        child: DefaultTabController(
                          length: 2,
                          child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                ProfileActivities(user: user),
                                Text("Posts"),
                              ]),
                        ),
                      ),
                    ]))
                  ],
                ));
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
            pageBuilder: (ctx, __, ___) => Scaffold(
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
