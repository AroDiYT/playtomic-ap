import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  // text field controllers
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();

  String errorMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _pwController.text.trim());
      setState(() {
        errorMessage = '';
        Navigator.pop(context);
      });
    } on FirebaseAuthException catch (e) {
      // https://firebase.google.com/docs/auth/admin/errors
      switch (e.code) {
        case 'invalid-email':
          setState(() {
            errorMessage = "Wrong email!";
          });

        case 'invalid-credential':
          setState(() {
            errorMessage = "Wrong password!";
          });

        default:
          setState(() {
            errorMessage = e.code;
          });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(230, 0, 0, 0),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(280, 0, 0, 0),
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Inloggen",
                    style:
                        GoogleFonts.roboto(color: Colors.white, fontSize: 20)),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "E-mail",
                  style: GoogleFonts.roboto(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 20,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.white, width: 1),
                            top: BorderSide.none,
                            right: BorderSide.none,
                            left: BorderSide.none)),
                    child: TextField(
                      controller: _emailController,
                      style: GoogleFonts.roboto(color: Colors.white),
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Wachtwoord",
                  style: GoogleFonts.roboto(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 20,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.white, width: 1),
                            top: BorderSide.none,
                            right: BorderSide.none,
                            left: BorderSide.none)),
                    child: TextField(
                      controller: _pwController,
                      obscureText: true,
                      style: GoogleFonts.roboto(color: Colors.white),
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50,
                    child: GFButton(
                        text: "Inloggen",
                        disabledColor: Colors.grey,
                        textStyle: GoogleFonts.roboto(
                            color: Colors.white, fontSize: 18),
                        fullWidthButton: true,
                        shape: GFButtonShape.pills,
                        onPressed: signIn),
                  ),
                )
              ],
            ),
          ),
        )
        /*
      SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // Greeting text
            const Text(
              "Hello",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Welcome back.",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),

            // Email field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: "Email"),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            // Password field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: _pwController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: "Password"),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            // Sign in button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: signIn,
                child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(12)),
                    child: const Center(
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    )),
              ),
            ),
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.red),
            )
          ]),
        ),
      ), */
        );
  }
}
