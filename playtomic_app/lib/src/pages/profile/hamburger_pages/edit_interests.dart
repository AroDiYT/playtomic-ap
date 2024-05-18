import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:playtomic_app/src/model/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditInterests extends StatefulWidget {
  final AppUser user;
  final Logger logger = Logger(printer: SimplePrinter(printTime: true));

  EditInterests({super.key, required this.user});

  @override
  _EditInterestsState createState() => _EditInterestsState();
}

class _EditInterestsState extends State<EditInterests> {
  final List<bool> selection = List.generate(7, (index) => false);

  final List<String> interests = [
    "Ontdek de gemeenschap",
    "Concurreren met anderen",
    "Speel met vrienden",
    "Mijn speelniveau kennen",
    "Mijn vooruitgang bijhouden",
    "Reserveer een baan",
    "Zoek mensen om mee te spelen"
  ];
  final List<Widget> interestIcons = [
    const ImageIcon(
      AssetImage("images/PT_logo.png"),
    ),
    const Icon(FontAwesomeIcons.trophy),
    const Icon(FontAwesomeIcons.heart),
    const Icon(FontAwesomeIcons.chartBar),
    const Icon(FontAwesomeIcons.arrowTrendUp),
    const Icon(FontAwesomeIcons.magnifyingGlass),
    const Icon(FontAwesomeIcons.peopleGroup),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Je interesses",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text("Wat zoek je in PlayTomic?"),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: List<Widget>.generate(
                      7,
                      (index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: InkWell(
                                hoverColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  widget.logger
                                      .d("Selected: ${interests[index]}");
                                  setState(() {
                                    selection[index] = !selection[index];
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color: (selection[index])
                                              ? Colors.blue.shade700
                                              : Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.all(14),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            interestIcons[index],
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Text(interests[index]),
                                          ],
                                        ),
                                        (selection[index])
                                            ? Icon(
                                                Icons.check,
                                                color: Colors.blue.shade700,
                                              )
                                            : const SizedBox(
                                                width: 10,
                                                height: 10,
                                              )
                                      ],
                                    ),
                                  ),
                                )),
                          )),
                )
              ],
            ),
            SizedBox(
              height: 50,
              child: GFButton(
                fullWidthButton: true,
                shape: GFButtonShape.pills,
                color: Colors.blue,
                onPressed: () {},
                child: const Text(
                  "Opslaan",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
