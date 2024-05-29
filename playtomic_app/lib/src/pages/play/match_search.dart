import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:logger/logger.dart';
import 'package:playtomic_app/src/database/database.dart';
import 'package:playtomic_app/src/model/club.dart';
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
            children: [const Text("Beschikbaar"), yourMatches()]),
      ),
    );
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
            Text(
              "${match.date.day} ${getMonth(match.date.month)} | ${match.date.hour.toString().padLeft(2, '0')}:${match.date.minute.toString().padLeft(2, '0')}",
              style: const TextStyle(fontWeight: FontWeight.bold),
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
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: (match.team1.isEmpty)
                        ? defaultTeamMember(1)
                        : FutureBuilder(
                            future: widget.db.loadUser(match.team1[0]),
                            builder: (ctx, snap) {
                              if (snap.hasData) {
                                AppUser user = snap.data!;

                                return Column(
                                  children: [
                                    GFAvatar(
                                      backgroundColor:
                                          const Color.fromARGB(255, 0, 20, 20),
                                      child: Text(user.name[0]),
                                    ),
                                    Expanded(
                                        child: Text(
                                      user.name.split(' ')[0],
                                      overflow: TextOverflow.ellipsis,
                                    ))
                                  ],
                                );
                              } else {
                                return defaultTeamMember(1);
                              }
                            },
                          ),
                  ),
                  Container(
                    width: 80,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: (match.team1.length <= 1)
                        ? defaultTeamMember(1)
                        : FutureBuilder(
                            future: widget.db.loadUser(match.team1[1]),
                            builder: (ctx, snap) {
                              if (snap.hasData) {
                                AppUser user = snap.data!;

                                return Column(
                                  children: [
                                    GFAvatar(
                                      backgroundColor:
                                          const Color.fromARGB(255, 0, 20, 20),
                                      child: Text(user.name[0]),
                                    ),
                                    Expanded(
                                        child: Text(
                                      user.name.split(' ')[0],
                                      overflow: TextOverflow.ellipsis,
                                    ))
                                  ],
                                );
                              } else {
                                return defaultTeamMember(1);
                              }
                            },
                          ),
                  ),
                  VerticalDivider(
                    thickness: 1,
                    color: Colors.grey.shade700,
                  ),
                  Container(
                    width: 80,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: (match.team2.isEmpty)
                        ? defaultTeamMember(2)
                        : FutureBuilder(
                            future: widget.db.loadUser(match.team2[0]),
                            builder: (ctx, snap) {
                              if (snap.hasData) {
                                AppUser user = snap.data!;

                                return Column(
                                  children: [
                                    GFAvatar(
                                      backgroundColor:
                                          const Color.fromARGB(255, 0, 20, 20),
                                      child: Text(user.name[0]),
                                    ),
                                    Expanded(
                                        child: Text(
                                      user.name.split(' ')[0],
                                      overflow: TextOverflow.ellipsis,
                                    ))
                                  ],
                                );
                              } else {
                                return defaultTeamMember(2);
                              }
                            },
                          ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 80,
                    child: (match.team2.length <= 1)
                        ? defaultTeamMember(2)
                        : FutureBuilder(
                            future: widget.db.loadUser(match.team2[1]),
                            builder: (ctx, snap) {
                              if (snap.hasData) {
                                AppUser user = snap.data!;

                                return Column(
                                  children: [
                                    GFAvatar(
                                      backgroundColor:
                                          const Color.fromARGB(255, 0, 20, 20),
                                      child: Text(user.name[0]),
                                    ),
                                    Expanded(
                                        child: Text(
                                      user.name.split(' ')[0],
                                      overflow: TextOverflow.ellipsis,
                                    ))
                                  ],
                                );
                              } else {
                                return defaultTeamMember(2);
                              }
                            },
                          ),
                  ),
                ],
              ),
            ),
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

  Widget defaultTeamMember(int team) {
    var children = (team == 1)
        ? [
            GFAvatar(
              backgroundColor: Colors.lightBlue.shade300,
              child: const Icon(Icons.person),
            ),
            const Text("Vrij")
          ]
        : [
            GFAvatar(
              backgroundColor: Colors.red.shade300,
              foregroundColor: Colors.red,
              child: const Icon(Icons.person),
            ),
            const Text("Vrij")
          ];

    return Column(
      children: children,
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
