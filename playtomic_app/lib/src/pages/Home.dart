import 'package:flutter/material.dart';


/// Displays a list of SampleItems.
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(title: const Text("Demo Playtomic")),
            body: const Center(child: Text("Hello!")),
          );
        }
}
