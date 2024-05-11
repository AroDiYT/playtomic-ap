import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClubCard extends StatelessWidget {
  final String title;
  final String location;
  final ImageProvider image;

  const ClubCard(
      {super.key,
      required this.title,
      required this.image,
      required this.location});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        width: 200,
        height: 300,
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image(
                  image: image,
                  height: 180,
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                title,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                location,
                style: GoogleFonts.roboto(color: Colors.grey.shade600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
