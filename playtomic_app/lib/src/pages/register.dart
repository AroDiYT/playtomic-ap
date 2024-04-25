import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // text field controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _telController = TextEditingController();
  final _pwController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _telController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Inschrijven",
                        style: GoogleFonts.roboto(
                            color: Colors.black, fontSize: 20)),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Naam en achternaam",
                      style:
                          GoogleFonts.roboto(color: Colors.black, fontSize: 14),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey.shade600, width: 1),
                                top: BorderSide.none,
                                right: BorderSide.none,
                                left: BorderSide.none)),
                        child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                              hintText: "Carolina Valera",
                              hintStyle: GoogleFonts.roboto(
                                  color: Colors.grey.shade600),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "E-mail",
                      style:
                          GoogleFonts.roboto(color: Colors.black, fontSize: 14),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey.shade600, width: 1),
                                top: BorderSide.none,
                                right: BorderSide.none,
                                left: BorderSide.none)),
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              hintText: "hola@playtomic.com",
                              hintStyle: GoogleFonts.roboto(
                                  color: Colors.grey.shade600),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Telefoon",
                      style:
                          GoogleFonts.roboto(color: Colors.black, fontSize: 14),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InternationalPhoneNumberInput(
                        textFieldController: _telController,
                        hintText: "470888888",
                        initialValue: PhoneNumber(isoCode: "32"),
                        selectorConfig: const SelectorConfig(
                            //showFlags: false
                            ),
                        onInputChanged: (PhoneNumber number) {
                          print(number.phoneNumber);
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Wachtwoord",
                      style:
                          GoogleFonts.roboto(color: Colors.black, fontSize: 14),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey.shade600, width: 1),
                                top: BorderSide.none,
                                right: BorderSide.none,
                                left: BorderSide.none)),
                        child: TextField(
                          controller: _pwController,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "*********",
                              hintStyle: GoogleFonts.roboto(
                                  color: Colors.grey.shade600),
                              border: InputBorder.none),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 50,
            child: GFButton(
              text: "Account aanmaken",
              shape: GFButtonShape.pills,
              disabledColor: Colors.grey,
              textStyle: GoogleFonts.roboto(color: Colors.white, fontSize: 18),
              onPressed: () {},
              fullWidthButton: true,
            ),
          ),
        ));
  }
}
