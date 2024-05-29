import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'package:playtomic_app/src/database/database.dart';
import 'package:playtomic_app/src/model/club.dart';
import 'package:playtomic_app/src/model/user.dart';
import 'package:playtomic_app/src/pages/play/club_page.dart';

class ClubSearch extends StatefulWidget {
  var logger = Logger(printer: SimplePrinter(colors: true));
  late Database db;
  AppUser user;

  ClubSearch({super.key, required this.user}) {
    db = Database(logger);
  }

  @override
  _ClubSearchState createState() => _ClubSearchState();
}

class _ClubSearchState extends State<ClubSearch> {
  // 2 views of this page: list (false) and map (true)
  bool view = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          iconSize: 18,
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Zoeken",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                setState(() {
                  view = !view;
                });
              },
              child: Text(
                (!view) ? "Kaart bekijken" : "Lijst bekijken",
                style: const TextStyle(color: Colors.blue, fontSize: 14),
              )),
        ],
      ),
      body: FutureBuilder(
        future: widget.db.getClubs(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text("Loading");
          } else {
            var clubs = snapshot.data!;

            return (!view) ? listView(clubs, context) : mapView(clubs);
          }
        },
      ),
    );
  }

  Widget mapView(List<Club> clubs) {
    return FlutterMap(
        mapController: MapController(),
        options: const MapOptions(
            initialCenter: LatLng(50.845334, 4.343755), initialZoom: 12),
        children: [
          TileLayer(
            tileProvider: CancellableNetworkTileProvider(),
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          ),
          MarkerLayer(
              markers: clubs
                  .map((e) => Marker(
                      point: LatLng(e.geo.latitude, e.geo.longitude),
                      alignment: Alignment.topCenter,
                      child: const Icon(
                        FontAwesomeIcons.locationDot,
                        size: 40,
                        color: Colors.black,
                      )))
                  .toList())
        ]);
  }

  Widget listView(List<Club> clubs, BuildContext context) {
    return CustomScrollView(slivers: [
      SliverAppBar(
        pinned: true,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(66),
          child: Column(
            children: [
              searchBox(),
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(Icons.tune_outlined),
                    const SizedBox(width: 10),
                    searchFilter([
                      const SizedBox(width: 6),
                      const Text(
                        "Padel",
                        style: TextStyle(color: Colors.white),
                      ),
                      const Icon(
                        Icons.arrow_drop_down_rounded,
                        color: Colors.white,
                        size: 30,
                      )
                    ]),
                    const SizedBox(width: 10),
                    searchFilter([const Text("Vandaag")]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      SliverList.builder(
        itemCount: clubs.length,
        itemBuilder: (ctx, i) => clubs
            .map((club) => InkWell(
                onTap: () => Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, _, __) => ClubPage(
                          club: club,
                          user: widget.user,
                          logger: widget.logger,
                        ))),
                child: clubCard(club)))
            .toList()[i],
      )
    ]);
  }

  SizedBox searchFilter(List<Widget> text) {
    return SizedBox(
      height: 30,
      child: GFButton(
        shape: GFButtonShape.pills,
        onPressed: () {},
        color: const Color.fromARGB(255, 0, 16, 39),
        child: Center(
          child: Row(
            children: text,
          ),
        ),
      ),
    );
  }

  Widget searchBox() {
    return SizedBox(
        width: MediaQuery.of(context).size.width - 50,
        height: 50,
        //margin: const EdgeInsets.symmetric(vertical: 20),
        child: const Row(
          children: [
            Icon(
              Icons.search,
              size: 28,
            ),
            SizedBox(width: 10),
            Expanded(
                child: Text(
              "Dicht bij mij",
              style: TextStyle(fontSize: 16),
            )),
            Icon(
              Icons.explore_outlined,
              size: 28,
            ),
            SizedBox(width: 10),
            Icon(
              Icons.favorite_border_outlined,
              size: 28,
            )
          ],
        ));
  }

  Widget clubCard(Club club) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GFImageOverlay(
            image: NetworkImage(club.image),
            height: 280,
            boxFit: BoxFit.cover,
            colorFilter: const ColorFilter.mode(
                Color.fromARGB(100, 0, 16, 39), BlendMode.multiply),
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    club.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                      Column(
                        children: [
                          Text(
                            "1u vanaf",
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                          Text(
                            "€27",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Text(club.location["city"])),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 40,
                  child: FutureBuilder(
                      future:
                          widget.db.getMatchesByDate(club.id, DateTime.now()),
                      builder: (ctx, snap) {
                        if (snap.hasData) {
                          List<int> times =
                              List.generate(30, (index) => (index * 30) + 480);
                          List<bool> available =
                              List.generate(30, (index) => true);

                          var matches = snap.data!;
                          for (var el in matches) {
                            if (el.date.hour < 13) {
                              int start =
                                  (((el.date.hour * 60 + el.date.minute) -
                                              480) /
                                          30)
                                      .floor();
                              int end = start + ((el.duration / 30).floor());
                              available.setRange(
                                  start, end, List.filled(end, false));
                            }
                          }

                          List<Widget> children = [];
                          for (int i = 0; i < 10; i++) {
                            if (available[i]) {
                              children.add(Container(
                                margin: const EdgeInsets.only(right: 6),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                    "${(times[i] / 60).floor().toString().padLeft(2, '0')}:${(times[i] % 60).toString().padLeft(2, '0')}"),
                              ));
                            }
                          }

                          return ListView(
                              scrollDirection: Axis.horizontal,
                              children: children);
                        }

                        return Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(5)),
                          child: const Text(
                            "Er is geen beschikbaarheid in dit tijdslot.",
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
