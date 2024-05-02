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
            padding: const EdgeInsets.only(left: 16),
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
                  height: 50,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
