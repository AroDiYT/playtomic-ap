import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ProfilePosts extends StatelessWidget {
  const ProfilePosts({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      child: Column(
        children: [
          const Image(
            image: AssetImage("images/noposts.png"),
            width: 100,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Welkom bij je persoonlijke feed. Hier vind je alle berichten die je deelt met de rest van je community. Wil je beginnen?",
            style: TextStyle(color: Color.fromARGB(255, 0, 15, 43)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            width: 200,
            child: GFButton(
              onPressed: () {},
              shape: GFButtonShape.pills,
              color: const Color.fromARGB(255, 0, 15, 43),
              text: "Maak een publicatie",
              textStyle: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
