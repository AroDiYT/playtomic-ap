import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  // text field controllers
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();

  String errorMessage = '';

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _pwController.text.trim());
      setState(() {
        errorMessage = '';
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
      backgroundColor: Colors.grey[300],
      body: SafeArea(
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
      ),
    );
  }
}
