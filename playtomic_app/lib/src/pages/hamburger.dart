import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playtomic_app/src/user.dart';

class Hamburger extends StatefulWidget {
  final AppUser user;

  const Hamburger({super.key, required this.user});

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
              Row(children: [
                SizedBox(
                  width: 150,
                  height: 30,
                  child: GFButton(
                    onPressed: () {},
                    color: Colors.indigo.shade900,
                    shape: GFButtonShape.pills,
                    textColor: Colors.amber,
                    text: "Ga voor Premium",
                    textStyle: const TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 150,
                  height: 30,
                  child: GFButton(
                    onPressed: () {},
                    color: Colors.white,
                    textColor: Colors.blue,
                    shape: GFButtonShape.pills,
                    text: "Profiel delen",
                    textStyle: const TextStyle(fontSize: 12),
                  ),
                ),
              ]),
              const SizedBox(height: 20),
              Text("Mijn Account",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    settingsCategory(
                        title: "Profiel bewerken",
                        description:
                            "Bewerk naam, e-mail, telefoonnummer, locatie,..."),
                    settingsCategory(
                        title: "Mijn activiteit",
                        description:
                            "Wedstrijden, klassen, competities, groepen"),
                    settingsCategory(
                        title: "Mijn betalingen",
                        description:
                            "Betaalmethoden, Transacties, Lidmaadschap"),
                    settingsCategory(
                        title: "Instellingen",
                        description:
                            "Privacy, meldingen, beveiliging configureren,..."),
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
                    settingsCategory(title: "Help", description: ""),
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
                        title: "Gebruikersvoorwaarden", description: ""),
                    settingsCategory(title: "Privacybeleid", description: ""),
                  ],
                ),
              ),
              signOut(context),
            ],
          ),
        ),
      ),
    );
  }

  Row settingsCategory({required String title, required String description}) {
    return Row(
      children: [
        const Icon(Icons.person),
        Column(
          children: [Text(title), Text(description)],
        ),
        SvgPicture.asset(
          "images/chevron-forward-outline.svg",
          height: 28,
          colorFilter: ColorFilter.mode(Colors.grey.shade800, BlendMode.srcIn),
        ),
      ],
    );
  }

  MaterialButton signOut(BuildContext context) {
    return MaterialButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.pop(context);
        },
        color: Colors.grey,
        child: const Text("Sign Out"));
  }
}
