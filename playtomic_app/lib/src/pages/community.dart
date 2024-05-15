import 'package:flutter/material.dart';
import 'package:playtomic_app/src/Match/match.dart';
import 'package:playtomic_app/src/Match/match_card.dart';
import 'package:playtomic_app/src/settings/settings_view.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  
  _CommunityState createState() => _CommunityState();
}
void _handleCreateMatch(clubLocation) {
  if (clubLocation != null) {
    createEmptyMatch(clubLocation!);
  } else {
    
    print("failed");
  }
}

class _CommunityState extends State<Community> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 80,
          title: const Row(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: ImageIcon(
                AssetImage("assets/images/PT_logo.png"),
                size: 30,
              ),
            ),
          ]),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.person_add_alt_outlined)),
            IconButton(
                onPressed: () {
                  Navigator.restorablePushNamed(
                      context, SettingsView.routeName);
                },
                icon: const Icon(Icons.chat_bubble_outline)),
            IconButton(
                onPressed: () {
                  Navigator.restorablePushNamed(
                      context, SettingsView.routeName);
                },
                icon: const Icon(Icons.notifications_none_outlined))
          ]),
      body: CreateMatchCard(
        onTap: () {
          
          
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Select Club Location'),
                content: const Text('Choose the club location for the match.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); 
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      
                      var clubLocation = 'Select Club';
                      Navigator.pop(context);
                      
                      _handleCreateMatch(clubLocation);
                    },
                    child: const Text('Select'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
