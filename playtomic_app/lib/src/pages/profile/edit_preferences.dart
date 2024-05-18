import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:playtomic_app/src/model/user.dart';

class EditPreferences extends StatefulWidget {
  final AppUser user;
  final Logger logger = Logger(printer: SimplePrinter(printTime: true));

  EditPreferences({super.key, required this.user});

  @override
  _EditPreferencesState createState() => _EditPreferencesState();
}

class _EditPreferencesState extends State<EditPreferences>
    with SingleTickerProviderStateMixin {
  static const List<Tab> tabTitles = <Tab>[
    Tab(text: "Padel"),
    Tab(text: "Tennis")
  ];
  late TabController _tabController;

  final List<bool> selectedHand = [false, false, false];
  final List<bool> selectedPosition = [false, false, false];
  final List<bool> selectedMatchType = [false, false, false];
  final List<bool> selectedTime = [false, false, false, false];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabTitles.length);

    widget.logger.d(widget.user.preferences);

    if (widget.user.preferences["hand"] != -1) {
      selectedHand[widget.user.preferences["hand"]!] = true;
    }
    if (widget.user.preferences["position"] != -1) {
      selectedPosition[widget.user.preferences["position"]!] = true;
    }
    if (widget.user.preferences["type"] != -1) {
      selectedMatchType[widget.user.preferences["type"]!] = true;
    }
    if (widget.user.preferences["favTime"] != -1) {
      selectedTime[widget.user.preferences["favTime"]!] = true;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: appbar(context),
        body: TabBarView(
          controller: _tabController,
          children: [padel(), tennis()],
        ));
  }

  /// Widget with different selection sections to change your preferences for
  /// playing padel.
  Widget padel() {
    final List<String> handTypes = ["Rechtshanding", "Linkshandig", "Beide"];
    final List<String> positionTypes = [
      "Forehand",
      "Backhand",
      "Beide helften"
    ];
    final List<String> matchTypes = [
      "Concurrerend",
      "Vriendschappelijk",
      "Beide"
    ];
    final List<String> timeTypes = [
      "Ochtend",
      "Middag",
      "Avond",
      "De hele dag"
    ];

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Beste hand",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          toggleButtons(selectedHand, handTypes),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Baanpositie",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          toggleButtons(selectedPosition, positionTypes),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Type partij",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          toggleButtons(selectedMatchType, matchTypes),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Mijn favoriete tijd om te spelen",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          toggleButtons(selectedTime, timeTypes),
        ],
      ),
    );
  }

  /// Generates toggle buttons for the items provided in the lists [selection] and [text].
  ToggleButtons toggleButtons(List<bool> selection, List<String> text) {
    return ToggleButtons(
      renderBorder: false,
      fillColor: Colors.grey.shade100,
      splashColor: Colors.grey.shade100,
      hoverColor: Colors.grey.shade100,
      isSelected: selection,
      children: List<Widget>.generate(
          selection.length,
          (index) => Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: selection[index]
                          ? const Color.fromARGB(255, 0, 21, 37)
                          : Colors.white,
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(text[index],
                          style: TextStyle(
                              color: (selection[index])
                                  ? Colors.white
                                  : Colors.black)),
                    ),
                  ),
                ),
              )),
      onPressed: (int index) {
        widget.logger.d("Selected: ${text[index]}");
        setState(() {
          for (int i = 0; i < selection.length; i++) {
            selection[i] = i == index;
          }
        });
      },
    );
  }

  Widget tennis() {
    return const Text("Tennis");
  }

  /// Appbar with a title and a back button.
  AppBar appbar(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      leading: IconButton(
          onPressed: () {
            widget.logger.d("Back button pressed");

            widget.user.preferences["hand"] = selectedHand.indexOf(true);
            widget.user.preferences["position"] =
                selectedPosition.indexOf(true);
            widget.user.preferences["type"] = selectedMatchType.indexOf(true);
            widget.user.preferences["favTime"] = selectedTime.indexOf(true);
            widget.logger.d("Updated user preferences");
            widget.logger.d(widget.user.preferences);

            Navigator.pop(context);
            widget.logger.d("Go back");
          },
          icon: const Icon(Icons.arrow_back)),
      backgroundColor: Colors.grey.shade100,
      centerTitle: true,
      title: const Text(
        "Voorkeuren van de speler",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      bottom: TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.indigo.shade900,
          indicatorColor: Colors.indigo.shade900,
          splashFactory: NoSplash.splashFactory,
          tabs: tabTitles),
    );
  }
}