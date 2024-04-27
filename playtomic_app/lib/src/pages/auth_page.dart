import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getwidget/getwidget.dart';
import 'package:playtomic_app/src/pages/login.dart';
import 'package:playtomic_app/src/pages/register.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/loginimage_9-16.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Color.fromARGB(255, 21, 49, 63), BlendMode.multiply))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 200,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ImageIcon(
                AssetImage("assets/images/PT_logo.png"),
                size: 40,
                color: Colors.white,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'P L A Y T O M I C',
                style: TextStyle(
                    fontFamily: 'Naville',
                    fontSize: 20,
                    decoration: TextDecoration.none,
                    color: Colors.white),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              "Meld je aan voor de grootste \ncommunity van racketsporten",
              style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w300)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              "Maak een account aan",
              style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w400)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: GFButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const Register()));
              },
              text: "Inschrijven",
              shape: GFButtonShape.pills,
              fullWidthButton: true,
              color: Colors.indigoAccent.shade700,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: GFButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const LoginPage()));
              },
              text: "Aanmelden",
              shape: GFButtonShape.pills,
              fullWidthButton: true,
              color: Colors.white,
              type: GFButtonType.outline,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Of ga verder met:",
                style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w400))),
          ),
          Material(
            type: MaterialType.transparency,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GFIconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/images/f_logo.png",
                  ),
                  color: const Color.fromARGB(255, 0x08, 0x66, 0xff),
                ),
                const SizedBox(
                  width: 30,
                ),
                GFIconButton(
                    icon: Image.asset("assets/images/g_logo.png"),
                    color: Colors.white,
                    onPressed: () {})
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Text(
                "Door te registreren accepteer je onze gebruikersvoorwaarden en privacybeleid",
                style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w400))),
          )
        ],
      ),
    );
  }
}
