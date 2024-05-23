import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:playtomic_app/src/model/club.dart';
import 'package:playtomic_app/src/model/user.dart';
import 'package:playtomic_app/src/pages/play/booking.dart';

class ClubPage extends StatefulWidget {
  Club club;
  AppUser user;
  Logger logger;

  ClubPage(
      {super.key,
      required this.club,
      required this.user,
      required this.logger});

  @override
  _ClubPageState createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var tabNames = <Tab>[
    const Tab(text: "Home"),
    const Tab(text: "Reserveren"),
    const Tab(text: "Competities"),
  ];
  late List<Widget> tabs;

  @override
  initState() {
    _tabController =
        TabController(length: tabNames.length, vsync: this, initialIndex: 1);
    tabs = <Widget>[
      const Text("Home", style: TextStyle(fontSize: 16)),
      Booking(
        logger: widget.logger,
        club: widget.club,
        user: widget.user,
      ),
      const Text("Competities", style: TextStyle(fontSize: 16))
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: [
        SliverAppBar(
          pinned: true,
          automaticallyImplyLeading: false,
          expandedHeight: 300,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(128, 255, 255, 255)),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_outlined),
                    onPressed: () => Navigator.pop(context),
                  )),
              Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(128, 255, 255, 255)),
                  child: IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () => Navigator.pop(context),
                  ))
            ],
          ),
          flexibleSpace: Image.network(
            widget.club.image,
            fit: BoxFit.cover,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(63),
            child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10))),
                child: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.club.name,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  widget.club.location["street"] +
                                      " " +
                                      widget.club.location["nr"].toString() +
                                      ", " +
                                      widget.club.location["city"],
                                  style: const TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                            const Icon(
                              Icons.favorite_border_outlined,
                            )
                          ],
                        )),
                    SizedBox(
                        height: 30,
                        child: TabBar(
                            controller: _tabController,
                            isScrollable: false,
                            indicatorColor:
                                const Color.fromARGB(255, 0, 20, 20),
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: const Color.fromARGB(255, 0, 20, 20),
                            tabs: tabNames))
                  ],
                )),
          ),
        ),
        SliverFillRemaining(
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: tabs,
          ),
        )
      ],
    );
  }
}
