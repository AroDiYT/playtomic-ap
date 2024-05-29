import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:logger/logger.dart';
import 'package:playtomic_app/src/database/database.dart';
import 'package:playtomic_app/src/model/match.dart';
import 'package:playtomic_app/src/model/user.dart';

class MatchSearch extends StatefulWidget {
  Database db = Database(Logger(printer: SimplePrinter()));
  AppUser user;

  MatchSearch({super.key, required this.user});

  @override
  _MatchSearchState createState() => _MatchSearchState();
}

class _MatchSearchState extends State<MatchSearch>
    with SingleTickerProviderStateMixin {
  var tabTitles = <Widget>[
    const SizedBox(height: 40, child: Center(child: Text("Beschikbaar"))),
    const SizedBox(height: 40, child: Center(child: Text("Jouw wedstrijden")))
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabTitles.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (ctx, val) => [
          SliverAppBar(
            scrolledUnderElevation: 0,
            pinned: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
            ),
            title: const Text("Open wedstrijden",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    const Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    TabBar(
                        controller: _tabController,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: const Color.fromARGB(255, 0, 20, 20),
                        indicatorColor: const Color.fromARGB(255, 0, 20, 20),
                        splashFactory: NoSplash.splashFactory,
                        tabs: tabTitles),
                  ],
                ),
              ),
            ),
          )
        ],
        body: TabBarView(
            controller: _tabController,
            children: [openMatches(), yourMatches()]),
      ),
    );
  }

  Widget openMatches() {
    return FutureBuilder(
        future: widget.db.getOpenMatches(),
        builder: (ctx, snap) {
          if (snap.hasData) {
            List<PadelMatch> matches = snap.data!;

            if (matches.isEmpty) return const Text("OOPS! No matches found.");

            return Column(
                children: matches.map((match) => matchCard(match)).toList());
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: Color.fromARGB(255, 0, 20, 20),
            ));
          }
        });
  }

  Widget yourMatches() {
    return FutureBuilder(
        future: widget.db.getMatchesByUser(widget.user),
        builder: (ctx, snap) {
          if (snap.hasData) {
            List<PadelMatch> matches = snap.data!;

            return Column(
                children: matches.map((match) => matchCard(match)).toList());
          } else {
            return const Text("OOPS! No matches found.");
          }
        });
  }

  Widget matchCard(PadelMatch match) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(10),
      height: 240,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${match.date.day} ${getMonth(match.date.month)} | ${match.date.hour.toString().padLeft(2, '0')}:${match.date.minute.toString().padLeft(2, '0')}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                (match.isPublic)
                    ? const Text("Open match")
                    : const Text("Privé match")
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Icon(Icons.signal_cellular_alt_outlined),
                SizedBox(
                  width: 6,
                ),
                Expanded(
                  child: Text(
                    "Type wedstrijd onbekend",
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: Future.wait([
                  (match.team1.isNotEmpty)
                      ? widget.db.loadUser(match.team1[0])
                      : Future.value(null),
                  (match.team1.length > 1)
                      ? widget.db.loadUser(match.team1[1])
                      : Future.value(null),
                  (match.team2.isNotEmpty)
                      ? widget.db.loadUser(match.team2[0])
                      : Future.value(null),
                  (match.team2.length > 1)
                      ? widget.db.loadUser(match.team2[1])
                      : Future.value(null),
                ]),
                builder: (context, snapshot) {
                  var players = List.generate(4, (index) => teamMember(null));

                  if (snapshot.hasData) {
                    players = snapshot.data!.map((e) => teamMember(e)).toList();
                  }

                  return IntrinsicHeight(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        players[0],
                        players[1],
                        VerticalDivider(
                          thickness: 1,
                          color: Colors.grey.shade700,
                        ),
                        players[2],
                        players[3],
                      ]));
                }),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const ImageIcon(AssetImage("assets/images/PT_logo.png"),
                          size: 30),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(match.club.name),
                          Text(
                            match.club.location["city"],
                            style: TextStyle(color: Colors.grey.shade700),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 50,
                    child: Column(
                      children: [
                        Text(
                          "€ 8",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        Text("90 min", style: TextStyle(color: Colors.blue))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget teamMember(AppUser? user) {
    var children = <Widget>[];

    if (user == null) {
      children = [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              border: Border.all(color: Colors.blue)),
          child: const Icon(
            Icons.add,
            color: Colors.blue,
          ),
        ),
        const Text("Vrij")
      ];
    } else {
      children = [
        GFAvatar(
          backgroundColor: const Color.fromARGB(255, 0, 20, 20),
          child: Text(user.name[0]),
        ),
        Expanded(
            child: Text(
          user.name.split(' ')[0],
          overflow: TextOverflow.ellipsis,
        ))
      ];
    }

    return Container(
      width: 80,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: children,
      ),
    );
  }

  String getMonth(int monthNr) {
    switch (monthNr) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Maa";
      case 4:
        return "Apr";
      case 5:
        return "Mei";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Okt";
      case 11:
        return "Nov";
      case 12:
        return "Dec";

      default:
        return "XXX";
    }
  }
}
