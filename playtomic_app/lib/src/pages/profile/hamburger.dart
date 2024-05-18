import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playtomic_app/src/pages/profile/hamburger_pages/edit_profile.dart';
import 'package:playtomic_app/src/user.dart';
import 'package:logger/logger.dart';

class Hamburger extends StatefulWidget {
  final AppUser user;

  const Hamburger({super.key, required this.user});

  @override
  _HamburgerState createState() => _HamburgerState();
}

class _HamburgerState extends State<Hamburger> {
  var logger = Logger(
    printer: SimplePrinter(printTime: true),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              logger.d("Back button pressed");
              Navigator.pop(context);
              logger.d("Go back");
            },
            icon: const Icon(Icons.close)),
        backgroundColor: Colors.grey.shade100,
      ),
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user.name,
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      (widget.user.hasPremium)
                          ? const Text("Premium account")
                          : const Text("Standaard account")
                    ],
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
              const SizedBox(
                height: 20,
              ),
              Row(children: [
                getPremiumBtn(),
                const SizedBox(
                  width: 20,
                ),
                shareProfileBtn(),
              ]),
              const SizedBox(height: 20),
              Text("Mijn Account",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        logger.d("Edit Profile button pressed");
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (ctx, __, ___) => EditProfile(
                                      user: widget.user,
                                    )));
                        logger.d("Going to Edit Profile page");
                      },
                      child: settingsCategory(
                          title: "Profiel bewerken",
                          description:
                              "Bewerk naam, e-mail, telefoonnummer, locatie,...",
                          icon: Icons.person_outline),
                    ),
                    settingsCategory(
                        title: "Mijn activiteit",
                        description:
                            "Wedstrijden, klassen, competities, groepen",
                        icon: Icons.sports_tennis_outlined),
                    settingsCategory(
                        title: "Mijn betalingen",
                        description:
                            "Betaalmethoden, Transacties, Lidmaadschap",
                        icon: Icons.wallet_outlined),
                    settingsCategory(
                        title: "Instellingen",
                        description:
                            "Privacy, meldingen, beveiliging configureren,...",
                        icon: Icons.settings_outlined),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text("Ondersteuning",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    settingsCategory(
                        title: "Help", icon: Icons.add_comment_outlined),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text("Legal",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    settingsCategory(
                        title: "Gebruikersvoorwaarden",
                        icon: Icons.description_outlined),
                    settingsCategory(
                        title: "Privacybeleid",
                        icon: Icons.remove_red_eye_outlined),
                  ],
                ),
              ),
              const SizedBox(
                height: 200,
              ),
              signOut(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget shareProfileBtn() {
    return SizedBox(
      width: 150,
      height: 30,
      child: GFButton(
        highlightElevation: 0,
        hoverElevation: 0,
        onPressed: () {},
        color: Colors.white,
        shape: GFButtonShape.pills,
        boxShadow:
            const BoxShadow(color: Colors.blue, blurRadius: 0, spreadRadius: 2),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.upload,
                color: Colors.blue,
              ),
              Text("Profiel delen",
                  style: TextStyle(fontSize: 12, color: Colors.blue)),
            ],
          ),
        ),
      ),
    );
  }

  Widget getPremiumBtn() {
    return SizedBox(
      width: 150,
      height: 30,
      child: GFButton(
        highlightElevation: 0,
        hoverElevation: 0,
        onPressed: () {},
        color: Colors.indigo.shade900,
        shape: GFButtonShape.pills,
        boxShadow: BoxShadow(
            color: Colors.indigo.shade900, blurRadius: 0, spreadRadius: 2),
        child: const Text(
          "Ga voor Premium",
          style: TextStyle(fontSize: 12, color: Colors.amber),
        ),
      ),
    );
  }

  Widget settingsCategory(
      {required String title, String? description, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (description != null) Text(description)
                ],
              ),
            ],
          ),
          SvgPicture.asset(
            "images/chevron-forward-outline.svg",
            height: 28,
            colorFilter:
                ColorFilter.mode(Colors.grey.shade800, BlendMode.srcIn),
          ),
        ],
      ),
    );
  }

  Widget signOut(BuildContext context) {
    return GFButton(
      hoverElevation: 0,
      highlightElevation: 0,
      type: GFButtonType.transparent,
      onPressed: () {
        logger.d("signOutBtn clicked");
        FirebaseAuth.instance.signOut();
        logger.d("Signed out of FireBase");
        Navigator.pop(context);
        logger.d("Go back to main page");
      },
      child: const Row(
        children: [
          Icon(
            Icons.power_settings_new_outlined,
            color: Colors.red,
            size: 24,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            "Sign Out",
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
