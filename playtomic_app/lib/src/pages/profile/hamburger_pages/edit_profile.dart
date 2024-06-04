import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:logger/logger.dart';
import 'package:playtomic_app/src/database/database.dart';
import 'package:playtomic_app/src/model/user.dart';
import 'package:playtomic_app/src/pages/profile/edit_preferences.dart';
import 'package:playtomic_app/src/pages/profile/hamburger_pages/edit_interests.dart';

class EditProfile extends StatefulWidget {
  final AppUser user;
  final Logger logger = Logger(printer: SimplePrinter(printTime: true));

  EditProfile({
    super.key,
    required this.user,
  });

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool userinfoChanged = false;

  var logger = Logger(printer: SimplePrinter(printTime: true));
  var genderChoices = const ["Mannelijk", "Vrouwelijk", "Zeg ik liever niet"];
  DateTime dob = DateTime(1800);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                avatar(),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Persoonlijke informatie",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: personalInfoForm(context),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Speler voorkeuren",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  hoverColor: Colors.transparent,
                  onTap: () {
                    widget.logger.d("Edit Preferences button pressed");
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (ctx, anim1, anim2) => EditPreferences(
                                  user: widget.user,
                                ))).then((value) => setState(() {}));
                    widget.logger.d("Going to EditPreferences page");
                  },
                  child: otherSettingsBtn(
                      title: "Mijn voorkeuren bewerken",
                      description:
                          "Beste hand, kant van de baan, type wedstrijd, beste tijd",
                      icon: Icons.sports_baseball_outlined),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Belangen",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  hoverColor: Colors.transparent,
                  onTap: () {
                    widget.logger.d("Edit Interests button pressed");
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (ctx, anim1, anim2) => EditInterests(
                                  user: widget.user,
                                ))).then((value) => setState(() {}));
                    widget.logger.d("Going to EditInterests page");
                  },
                  child: otherSettingsBtn(
                      title: "Mijn interesses bewerken",
                      description:
                          "Spelen met vrienden, wedstrijden, uitdagingen",
                      icon: Icons.sports_tennis_outlined),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Je wachtwoord",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: changePasswordBtn(),
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ));
  }

  InkWell changePasswordBtn() {
    return InkWell(
      onTap: () {},
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Wachtwoord",
                style: TextStyle(fontSize: 6),
              ),
              Text(
                "••••••••••",
                style: TextStyle(
                    letterSpacing: 10,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ],
          ),
          Icon(Icons.edit)
        ],
      ),
    );
  }

// TODO: update user info in database
  Column personalInfoForm(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          initialValue: widget.user.name,
          onChanged: (name) => widget.user.name = name,
          decoration: const InputDecoration(
              border: InputBorder.none,
              label: Text(
                "Naam en achternaam",
                style: TextStyle(fontSize: 14),
              )),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          initialValue: widget.user.email,
          decoration: const InputDecoration(
              border: InputBorder.none,
              label: Text(
                "E-mail",
                style: TextStyle(fontSize: 14),
              )),
        ),
        const SizedBox(
          height: 10,
        ),
        InternationalPhoneNumberInput(
          inputDecoration: const InputDecoration(
              border: InputBorder.none,
              label: Text(
                "Telefoon",
                style: TextStyle(fontSize: 14),
              )),
          onInputChanged: (number) {
            widget.user.tel = number.toString();
          },
          selectorConfig:
              const SelectorConfig(selectorType: PhoneInputSelectorType.DIALOG),
          initialValue: PhoneNumber(isoCode: "BE"),
        ),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField(
            decoration: const InputDecoration(
                border: InputBorder.none,
                label: Text(
                  "Geslacht",
                  style: TextStyle(fontSize: 14),
                )),
            value: genderChoices[0],
            items: genderChoices.map((String val) {
              return DropdownMenuItem(
                value: val,
                child: Text(
                  val,
                ),
              );
            }).toList(),
            onChanged: (item) {
              widget.user.gender = (item == "Mannelijk"
                  ? 0
                  : item == "Vrouwelijk"
                      ? 1
                      : 2);
            }),
        const SizedBox(
          height: 16,
        ),
        InkWell(
          onTap: () {
            selectDate(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (dob == DateTime(1800))
                  ? const Text("Geboortedatum")
                  : Column(
                      children: [
                        const Text(
                          "Geboortedatum",
                          style: TextStyle(fontSize: 10),
                        ),
                        Text(
                            "${dob.day.toString().padLeft(2, '0')}/${dob.month.toString().padLeft(2, '0')}/${dob.year}"),
                      ],
                    ),
              const Icon(Icons.calendar_month_outlined)
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          maxLines: null,
          maxLength: 160,
          initialValue: widget.user.bio,
          decoration: const InputDecoration(
              border: InputBorder.none,
              label: Text(
                "Beschrijving",
                style: TextStyle(fontSize: 14),
              )),
        ),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            selectDate(context);
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Waar speel je?"), Icon(Icons.explore)],
          ),
        ),
      ],
    );
  }

  Widget otherSettingsBtn(
      {required String title,
      required String description,
      required IconData icon}) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 300,
                child: Row(
                  children: [
                    Icon(icon),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                          Text(
                            description,
                            style: GoogleFonts.roboto(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SvgPicture.asset(
                  "images/chevron-forward-outline.svg",
                  height: 28,
                  colorFilter:
                      ColorFilter.mode(Colors.grey.shade800, BlendMode.srcIn),
                ),
              )
            ],
          ),
        ));
  }

  Center avatar() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GFAvatar(
              radius: 40,
              backgroundColor: Colors.indigo.shade900,
              child: Text(
                widget.user.name
                    .toString()
                    .trim()
                    .split(' ')
                    .map((l) => l[0])
                    .first,
                style: const TextStyle(
                    letterSpacing: 3,
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
          Text(
            "Profielfoto wijzigen",
            style: TextStyle(color: Colors.blue.shade700, fontSize: 12),
          )
        ],
      ),
    );
  }

  AppBar appbar(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      leading: IconButton(
          onPressed: () {
            logger.d("Back button pressed");
            Navigator.pop(context);
            logger.d("Go back");
          },
          icon: const Icon(Icons.arrow_back)),
      backgroundColor: Colors.grey.shade100,
      centerTitle: true,
      title: const Text(
        "Profiel bewerken",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      actions: [
        TextButton(
            onPressed: () async {
              logger.d("Pressed \"Save\"");
              await Database(logger)
                  .updateUser(widget.user.toMap(), widget.user.email);
            },
            child: const Text(
              "Opslaan",
              style: TextStyle(color: Colors.blue, fontSize: 14),
            ))
      ],
    );
  }

  /// Shows a datepicker and changes the date of birth after you've picked a date
  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != dob || picked != null) {
      setState(() {
        dob = picked!;
      });
    }
  }
}
