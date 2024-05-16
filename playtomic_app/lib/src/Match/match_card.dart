import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:playtomic_app/src/Match/match_settings.dart';
import 'package:playtomic_app/src/pages/play/club_card.dart';

class CreateMatchCard extends StatelessWidget {
  const CreateMatchCard({super.key, required Null Function() onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _openMatchSettings(context);
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 32, 32, 32),
                ),
                width: 50,
                height: 50,
                child: const Icon(Icons.add_circle_outline,
                    size: 30, color: Colors.white),
              ),
              const SizedBox(height: 10),
              const Text(
                'Create Match',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                'Create a new match',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openMatchSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MatchSettingsView(
          selectedClub: 'Your Club',
          is1v1Mode: true,
          onSelectClub: (club) async {
            await _handleClub(context);
            // showDialog(
            //   context: context,
            //   builder: (context) {
            //     return AlertDialog(
            //       title: const Text('Select a Club'),
            //       content: const Text('TODO: Add list of clubcards.'),
            //       actions: [
            //         TextButton(
            //           onPressed: () {
            //             Navigator.pop(context); // Close the dialog
            //           },
            //           child: const Text('Close'),
            //         ),
            //       ],
            //     );
            //   },
            // );
            print('Selected club: $club');
          },
          onChangeMode: (is1v1) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Select the gamemode'),
                  content: const Text('TODO: Add a way to select 1V1 or 2V2'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the dialog
                      },
                      child: const Text('Close'),
                    ),
                  ],
                );
              },
            );
            print('Switched to ${is1v1 ? '1v1' : '2v2'} mode');
          },
          onInvite: () {
            // Handle invitation
            _handleInvite(context);
          },
          onConfirm: () {
            // Check match.dart
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Open your match'),
                  content: const Text('TODO: Connect after fixing Time, Clubs and invite. Creation Methods exist.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the dialog
                      },
                      child: const Text('Close'),
                    ),
                  ],
                );
              },
            );
            print("confirm wip");
          },
          onTimeSet: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Select a time slot'),
                  content: const Text('TODO: Add time in matches.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the dialog
                      },
                      child: const Text('Close'),
                    ),
                  ],
                );
              },
            );
            print("time WIP");
          },
        ),
      ),
    );
  }
}

void _handleInvite(BuildContext context) {
  // Show a dialog or navigate to invite people
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Invite People'),
        content: const Text('Invite people to the match.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text('Close'),
          ),
          // Add more buttons or widgets for inviting people
        ],
      );
    },
  );
}

Future<void> _handleClub(BuildContext ctx) async {
  var clubs = await FirebaseFirestore.instance.collection("matches").get();
  var cr = clubs.docs.map((DocumentSnapshot e) => ClubCard(title: e["title"], image: NetworkImage(e["image"]), location: e["location"]));
  showBottomSheet(context: ctx, builder: (BuildContext e) {
    return ListView(children: cr.toList());
  });
  print("testing");
}


