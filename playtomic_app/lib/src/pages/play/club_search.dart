import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:logger/logger.dart';
import 'package:playtomic_app/src/database/database.dart';
import 'package:playtomic_app/src/model/club.dart';

class ClubSearch extends StatefulWidget {
  var logger = Logger(printer: SimplePrinter(colors: true));
  late Database db;

  ClubSearch({super.key}) {
    db = Database(logger);
  }

  @override
  _ClubSearchState createState() => _ClubSearchState();
}

class _ClubSearchState extends State<ClubSearch> {
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
              onPressed: () {},
              child: const Text(
                "Kaart bekijken",
                style: TextStyle(color: Colors.blue, fontSize: 14),
              ))
        ],
      ),
      body: FutureBuilder(
        future: widget.db.getClubs(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text("Loading");
          } else {
            var clubs = snapshot.data!;
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
                itemBuilder: (ctx, i) =>
                    clubs.map((club) => clubCard(club)).toList()[i],
              )
            ]);
          }
        },
      ),
    );
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
              children: [
                Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Text(club.location["city"])),
                Container(
                  width: 70,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("19:00")]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
