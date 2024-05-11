import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playtomic_app/src/pages/play/club_card.dart';
import 'package:playtomic_app/src/pages/play/play_card.dart';

class PlayContent extends StatefulWidget {
  const PlayContent({super.key});

  @override
  State<PlayContent> createState() => _PlayContentState();
}

class _PlayContentState extends State<PlayContent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            height: 1,
            indent: 0,
            endIndent: 0,
          ),
          MaterialBanner(
              padding: EdgeInsets.all(20),
              content: Column(
                children: [
                  Row(
                    children: [
                      const Image(
                        image: AssetImage("images/PT_Premium_icon.png"),
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
                    colorFilter:
                        ColorFilter.mode(Colors.grey.shade800, BlendMode.srcIn),
                  ),
                )
              ]),
          const SizedBox(
            height: 20,
          ),
          // ignore: prefer_const_constructors
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            // ignore: prefer_const_constructors
            child: Column(
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
                        border:
                            Border.all(width: 2, color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(Icons.sports_tennis_outlined),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Wijzig jouw spelersvoorkeuren",
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
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
                              icon: Icon(Icons.arrow_right_alt_outlined))
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 30,
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
                            child: PlayCard(
                                title: "Een baan zoeken",
                                icon: Icons.search_outlined,
                                description: "Als je al weet met wie je speelt",
                                imagePath: "images/loginimage_9-16.jpg")),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: PlayCard(
                                title: "Lessen", icon: Icons.school_outlined)),
                        const SizedBox(
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
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                              width: 200,
                              height: 300,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2, color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        ),
                        const ClubCard(
                            title: "Urban Padel Brussels",
                            location: "Anderlecht",
                            image: NetworkImage(
                                "https://res.cloudinary.com/playtomic/image/upload/v1668930158/pro/tenants/71aa8a9f-a7cd-47e8-8e0c-8af69ba2c1a7/1668930157916.jpg")),
                        //const ClubCard()
                      ]),
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
                Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 2, color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("Wijzig jouw spelersvoorkeuren"),
                    )),
                const SizedBox(
                  height: 200,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
