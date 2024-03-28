import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({ super.key });

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Text(
      "Home Page"
    );
  }
}