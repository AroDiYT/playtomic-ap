import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:playtomic_app/src/model/club.dart';
import 'package:playtomic_app/src/model/user.dart';
import 'package:playtomic_app/src/pages/play/club_card.dart';
import 'package:playtomic_app/src/pages/play/club_page.dart';
import 'package:playtomic_app/src/pages/play/club_search.dart';
import 'package:playtomic_app/src/pages/play/play_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PlayContent extends StatefulWidget {
  const PlayContent({super.key});

  @override
  State<PlayContent> createState() => _PlayContentState();
}

class _PlayContentState extends State<PlayContent> {
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
        hasPremium: uData["hasPremium"]);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUser(),
      builder: (ctx, snap) {
        if (snap.data == null) {
          return const Center(child: CircularProgressIndicator());
        }

        AppUser user = snap.data!;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (user.hasPremium)
                  ? const SizedBox(
                      height: 0,
                    )
                  : Column(
                      children: [
                        const Divider(
                          height: 1,
                          indent: 0,
                          endIndent: 0,
                        ),
                        MaterialBanner(
                            padding: const EdgeInsets.all(20),
                            content: Column(
                              children: [
                                Row(
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                          "images/PT_Premium_icon.png"),
                                      width: 20,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text("een stap voor zijn".toUpperCase(),
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // ignore: prefer_const_constructors
                                Text(
                                    "Ontvang meldingen voor beschikbare velden, geef je wedstrijden meer zichtbaarheid en ontdek jouw geavanceerde statistieken")
                              ],
                            ),
                            actions: <Widget>[
                              IconButton(
                                onPressed: null,
                                icon: SvgPicture.asset(
                                  "images/chevron-forward-outline.svg",
                                  height: 28,
                                  colorFilter: ColorFilter.mode(
                                      Colors.grey.shade800, BlendMode.srcIn),
                                ),
                              )
                            ]),
                      ],
                    ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (user.preferences["hand"] != -1 &&
                            user.preferences["position"] != -1 &&
                            user.preferences["type"] != -1 &&
                            user.preferences["favTime"] != -1)
                        ? const SizedBox(
                            height: 0,
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Aankomende reserveringen...",
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2,
                                          color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Icon(
                                              Icons.sports_tennis_outlined),
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "Wijzig jouw spelersvoorkeuren",
                                                  style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16)),
                                              const Text(
                                                "Voorkeurshand, positie, wedstrijd type, mijn velden",
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const IconButton(
                                            onPressed: null,
                                            icon: Icon(
                                                Icons.arrow_right_alt_outlined))
                                      ],
                                    ),
                                  )),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                    Text(
                      "Vind jouw perfecte wedstrijd",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      pageBuilder: (ctx, _, __) => ClubSearch(
                                            user: user,
                                          ))),
                              child: const PlayCard(
                                  title: "Een baan boeken",
                                  icon: Icons.search_outlined,
                                  description:
                                      "Als je al weet met wie je speelt",
                                  imagePath: "images/loginimage_9-16.jpg"),
                            )),
                            const SizedBox(
                              width: 10,
                            ),
                            const Expanded(
                              child: PlayCard(
                                title: "Speel een wedstrijd",
                                icon: Icons.sports_tennis_outlined,
                                description:
                                    "Als je op zoek bent naar spelers van jouw niveau",
                                imagePath: "images/loginimage_9-16.jpg",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: PlayCard(
                                    title: "Lessen",
                                    icon: Icons.school_outlined)),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: PlayCard(
                                  title: "Competities",
                                  icon: Icons.shield_outlined),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Jouw clubs",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 300,
                      child: FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection("clubs")
                              .get(),
                          builder: ((context, snapshot) {
                            List<Widget> children = [];

                            // TODO: check if location is on

                            bool isLocationOn = false;
                            if (!isLocationOn) {
                              children.add(Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                    width: 200,
                                    height: 300,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 10, 20, 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Icon(Icons.location_on_outlined,
                                              size: 50),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            "Zoek clubs bij jou in de buurt",
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text("Locatie activeren"),
                                          const SizedBox(
                                            height: 50,
                                          ),
                                          GFButton(
                                            onPressed: () {},
                                            text: "Inschakelen",
                                            textColor: Colors.white,
                                            shape: GFButtonShape.pills,
                                            fullWidthButton: true,
                                            color: Colors.indigoAccent.shade700,
                                          )
                                        ],
                                      ),
                                    )),
                              ));
                            }

                            if (!snapshot.hasData) {
                              return const Center(child: Text('Loading..'));
                            } else {
                              children = children +
                                  snapshot.data!.docs
                                      .map((DocumentSnapshot document) {
                                    Map<String, dynamic> clubData = document
                                        .data()! as Map<String, dynamic>;
                                    return InkWell(
                                      onTap: () => Navigator.of(context).push(
                                          PageRouteBuilder(
                                              pageBuilder: (ctx, _, __) =>
                                                  ClubPage(
                                                    user: user,
                                                    club: Club(
                                                        name: clubData["name"],
                                                        image:
                                                            clubData["image"],
                                                        location: {
                                                          "street": clubData[
                                                                  "location"]
                                                              ["street"],
                                                          "nr": clubData[
                                                              "location"]["nr"],
                                                          "city": clubData[
                                                                  "location"]
                                                              ["city"],
                                                        }),
                                                    logger: Logger(
                                                        printer:
                                                            SimplePrinter()),
                                                  ))),
                                      child: ClubCard(
                                          title: clubData["name"],
                                          image:
                                              NetworkImage(clubData["image"]),
                                          location: clubData["location"]
                                              ["city"]),
                                    );
                                  }).toList();
                            }

                            return ListView(
                                scrollDirection: Axis.horizontal,
                                children: children);
                          })),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Hoe kan ik profiteren van Playtomic",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: 300,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                    width: 200,
                                    height: 300,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(20),
                                        image: const DecorationImage(
                                            image: NetworkImage(
                                                "https://padelmagazine.fr/wp-content/uploads/2024/02/lamperti-2024.jpg.webp"),
                                            fit: BoxFit.cover)),
                                    child: Text(
                                      "Een wedstrijd maken: eenvoudige handleiding",
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Column(
                                  children: [
                                    Container(
                                        width: 200,
                                        height: 145,
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2,
                                                color: Colors.grey.shade300),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.grey.shade900),
                                        child: Text(
                                          "Doe mee aan een wedstrijd met anderen",
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.white),
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        width: 200,
                                        height: 145,
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2,
                                                color: Colors.grey.shade300),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.grey.shade900
                                            // image: const DecorationImage(
                                            //     image: NetworkImage(
                                            //         "https://padelmagazine.fr/wp-content/uploads/2024/02/lamperti-2024.jpg.webp"),
                                            //     fit: BoxFit.cover)
                                            ),
                                        child: Text(
                                          "Je partner toevoegen aan een open wedstrijd",
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.white),
                                        )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                    width: 200,
                                    height: 300,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(20),
                                        image: const DecorationImage(
                                            image: NetworkImage(
                                                "https://padelmagazine.fr/wp-content/uploads/2024/02/lamperti-2024.jpg.webp"),
                                            fit: BoxFit.cover)),
                                    child: Text(
                                      "Maak een baanreservering",
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Column(
                                  children: [
                                    Container(
                                        width: 200,
                                        height: 145,
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2,
                                                color: Colors.grey.shade300),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.grey.shade900
                                            // image: const DecorationImage(
                                            //     image: NetworkImage(
                                            //         "https://padelmagazine.fr/wp-content/uploads/2024/02/lamperti-2024.jpg.webp"),
                                            //     fit: BoxFit.cover)
                                            ),
                                        child: Text(
                                          "Gesplitste betaling",
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.white),
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        width: 200,
                                        height: 145,
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2,
                                                color: Colors.grey.shade300),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.grey.shade900
                                            // image: const DecorationImage(
                                            //     image: NetworkImage(
                                            //         "https://padelmagazine.fr/wp-content/uploads/2024/02/lamperti-2024.jpg.webp"),
                                            //     fit: BoxFit.cover)
                                            ),
                                        child: Text(
                                          "Premium ervaringen",
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.white),
                                        )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                    width: 200,
                                    height: 300,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(20),
                                        image: const DecorationImage(
                                            image: NetworkImage(
                                                "https://padelmagazine.fr/wp-content/uploads/2024/02/lamperti-2024.jpg.webp"),
                                            fit: BoxFit.cover)),
                                    child: Text(
                                      "Resultaten uploaden",
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Column(
                                  children: [
                                    Container(
                                        width: 200,
                                        height: 145,
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2,
                                                color: Colors.grey.shade300),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.grey.shade900
                                            // image: const DecorationImage(
                                            //     image: NetworkImage(
                                            //         "https://padelmagazine.fr/wp-content/uploads/2024/02/lamperti-2024.jpg.webp"),
                                            //     fit: BoxFit.cover)
                                            ),
                                        child: Text(
                                          "Wedstrijdresultaten bewerken",
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.white),
                                          overflow: TextOverflow.clip,
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        width: 200,
                                        height: 145,
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2,
                                                color: Colors.grey.shade300),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.grey.shade900
                                            // image: const DecorationImage(
                                            //     image: NetworkImage(
                                            //         "https://padelmagazine.fr/wp-content/uploads/2024/02/lamperti-2024.jpg.webp"),
                                            //     fit: BoxFit.cover)
                                            ),
                                        child: Text(
                                          "Niveau's algoritme",
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.white),
                                        )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                    width: 200,
                                    height: 300,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(20),
                                        image: const DecorationImage(
                                            image: NetworkImage(
                                                "https://padelmagazine.fr/wp-content/uploads/2024/02/lamperti-2024.jpg.webp"),
                                            fit: BoxFit.cover)),
                                    child: Text(
                                      "Verbinden met je vrienden",
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white),
                                    )),
                              ),
                            ])),
                    const SizedBox(
                      height: 200,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
