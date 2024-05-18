import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:logger/logger.dart';
import 'package:playtomic_app/src/user.dart';

class EditProfile extends StatefulWidget {
  final AppUser user;

  const EditProfile({
    super.key,
    required this.user,
  });

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var logger = Logger(printer: SimplePrinter(printTime: true));
  var genderChoices = const ["Mannelijk", "Vrouwelijk", "Zeg ik liever niet"];
  DateTime dob = DateTime(1800);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar(context),
        body: Padding(
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
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: widget.user.name,
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
                      onInputChanged: (number) {},
                      selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.DIALOG),
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
                        onChanged: (item) {}),
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
                ),
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
            ],
          ),
        ));
  }

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
            onPressed: () {
              logger.d("Pressed \"Save\"");
            },
            child: const Text(
              "Opslaan",
              style: TextStyle(color: Colors.blue, fontSize: 14),
            ))
      ],
    );
  }
}
