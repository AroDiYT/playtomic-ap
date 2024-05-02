import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("Wijzig jouw spelersvoorkeuren"),
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

class PlayCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String? description;
  final String? imagePath;

  PlayCard(
      {super.key,
      required this.title,
      required this.icon,
      this.description,
      this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            if (imagePath != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(imagePath!, height: 75, fit: BoxFit.fitWidth),
                ],
              ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (imagePath != null)
                    const SizedBox(
                      height: 30,
                    ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 32, 32, 32)),
                    width: 50,
                    height: 50,
                    child: Icon(icon, size: 30, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    title,
                    style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                  ),
                  if (description != null)
                    const SizedBox(
                      height: 5,
                    ),
                  if (description != null)
                    Text(
                      description!,
                      style: GoogleFonts.roboto(),
                    )
                ],
              ),
            ),
          ],
        ));
  }
}
