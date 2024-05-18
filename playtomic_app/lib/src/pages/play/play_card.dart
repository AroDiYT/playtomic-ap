import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String? description;
  final String? imagePath;

  const PlayCard(
      {super.key,
      required this.title,
      required this.icon,
      this.description,
      this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            if (imagePath != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(imagePath!, height: 75, fit: BoxFit.fitWidth),
                ],
              ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (imagePath != null)
                    const SizedBox(
                      height: 30,
                    ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 32, 32, 32)),
                    width: 50,
                    height: 50,
                    child: Icon(icon, size: 30, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    title,
                    style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                  ),
                  if (description != null)
                    const SizedBox(
                      height: 5,
                    ),
                  if (description != null)
                    SizedBox(
                      height: 40,
                      child: Text(
                        description!,
                        style: GoogleFonts.roboto(),
                      ),
                    )
                ],
              ),
            ),
          ],
        ));
  }
}
