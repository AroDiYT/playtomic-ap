import 'package:flutter/material.dart';

class MatchSettingsView extends StatelessWidget {
  final String selectedClub;
  final bool is1v1Mode;
  final void Function(String) onSelectClub;
  final void Function(bool) onChangeMode;
  final void Function() onInvite;
  final void Function() onConfirm;
  final void Function() onTimeSet;

  const MatchSettingsView({
    Key? key,
    required this.selectedClub,
    required this.is1v1Mode,
    required this.onSelectClub,
    required this.onChangeMode,
    required this.onInvite,
    required this.onConfirm,
    required this.onTimeSet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Selected Club: $selectedClub'),
            ElevatedButton(
              onPressed: () {
                // Open a dialog or navigate to select club
                // For simplicity, let's just print a message
                print('Select Club');
              },
              child: const Text('Select Club'),
            ),
            const SizedBox(height: 16),
            Text('Mode: ${is1v1Mode ? '1v1' : '2v2'}'),
            ElevatedButton(
              onPressed: () {
                // Change the mode
                onChangeMode(!is1v1Mode);
              },
              child: Text(is1v1Mode ? 'Switch to 2v2' : 'Switch to 1v1'),
            ),
            const Text('Set Match Time'),
            ElevatedButton(
              onPressed: () {
                // Change the mode
                onTimeSet();
              },
              child: Text(is1v1Mode ? 'Switch to 2v2' : 'Switch to 1v1'),
            ),
            const SizedBox(height: 16),
            const Text('Invite people'),
            ElevatedButton(
              onPressed: () {
                // Invite people
                onInvite();
              },
              child: const Text('Invite People'),
            ),
            const Text('Confirm Match'),
            ElevatedButton(
              onPressed: () {
                // Invite people
                onConfirm();
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
