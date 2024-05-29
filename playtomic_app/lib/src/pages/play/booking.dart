import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:logger/logger.dart';
import 'package:playtomic_app/src/database/database.dart';
import 'package:playtomic_app/src/model/club.dart';
import 'package:playtomic_app/src/model/user.dart';

class Booking extends StatefulWidget {
  Logger logger;
  Club club;
  AppUser user;
  late Database db = Database(logger);

  Booking(
      {super.key,
      required this.logger,
      required this.club,
      required this.user});

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  var pickedDate = DateTime.now();
  var selectedTime = 480;
  List<DateTime> dates = List.empty(growable: true);
  late Future<List<bool>> reserved;

  @override
  void initState() {
    for (int i = 0; i < 60; i++) {
      dates.add(DateTime.now().add(Duration(days: i)));
    }
    reserved = refreshTimeslots();
    super.initState();
  }

  /// Gets the matches that have been booked for the day the user selected,
  /// and makes the corresponding timeslots unavailable;
  Future<List<bool>> refreshTimeslots() async {
    widget.logger.d("$this: Refreshing timeslots");

    //List<bool> slots = List.generate(30, (index) => false);
    return await widget.db
        .getMatchesByDate(widget.club.id, pickedDate)
        .then((taken) {
      List<bool> slots = List.generate(32, (index) => false);
      slots.setRange(30, 31, List.filled(2, true));

      if (taken.isNotEmpty) {
        widget.logger.d("$this: Checking retrieved matches");

        for (PadelMatch match in taken) {
          int start =
              (((match.date.hour * 60 + match.date.minute) - 480) / 30).floor();
          int end = start + ((match.duration / 30).floor());
          slots.setRange(start, end, List.filled(end, true));
        }
      }

      widget.logger.d("$this: $taken\n$slots");

      return slots;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Container(
                    height: 120,
                    width: 80,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: const Icon(Icons.sports_tennis_outlined),
                  ),
                  datePicker(context),
                ],
              ),
            ),
            FutureBuilder(
                future: reserved,
                builder: (ctx, snap) {
                  if (snap.hasData) {
                    var reservedSlots = snap.data!;
                    int selectedSlot = ((selectedTime - 480) / 30).floor();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: timePicker(ctx, reservedSlots)),
                        Container(
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Reserveer je plaats in een openbare reservering",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  "In een openbare reservering speel je mee met nieuwe, onbekende spelers van jouw niveau")
                            ],
                          ),
                        ),
                        if (!(reservedSlots[selectedSlot + 1] ||
                            reservedSlots[selectedSlot + 2]))
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            padding: const EdgeInsets.all(10),
                            height: 240,
                            width: 328,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey)),
                            child: Stack(
                              children: [
                                IntrinsicWidth(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${pickedDate.day} ${getMonth(pickedDate.month)} | ${(selectedTime / 60).floor().toString().padLeft(2, '0')}:${(selectedTime % 60).toString().padLeft(2, '0')}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Row(
                                        children: [
                                          Icon(Icons
                                              .signal_cellular_alt_outlined),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "De eerste speler bepaalt of het een competitie is.",
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
                                          children: [
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Column(
                                                children: [
                                                  GFAvatar(
                                                    backgroundColor:
                                                        Colors.red.shade300,
                                                    foregroundColor: Colors.red,
                                                    child: const Icon(
                                                        Icons.person),
                                                  ),
                                                  const Text("Vrij")
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Column(
                                                children: [
                                                  GFAvatar(
                                                    backgroundColor:
                                                        Colors.red.shade300,
                                                    foregroundColor: Colors.red,
                                                    child: const Icon(
                                                        Icons.person),
                                                  ),
                                                  const Text("Vrij")
                                                ],
                                              ),
                                            ),
                                            VerticalDivider(
                                              thickness: 1,
                                              color: Colors.grey.shade700,
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Column(
                                                children: [
                                                  GFAvatar(
                                                    backgroundColor: Colors
                                                        .lightBlue.shade300,
                                                    child: const Icon(
                                                        Icons.person),
                                                  ),
                                                  const Text("Vrij")
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Column(
                                                children: [
                                                  GFAvatar(
                                                    backgroundColor: Colors
                                                        .lightBlue.shade300,
                                                    child: const Icon(
                                                        Icons.person),
                                                  ),
                                                  const Text("Vrij")
                                                ],
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
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const ImageIcon(
                                              AssetImage(
                                                  "assets/images/PT_logo.png"),
                                              size: 30),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(widget.club.name),
                                              Text(
                                                widget.club.location["city"],
                                                style: TextStyle(
                                                    color:
                                                        Colors.grey.shade700),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 80,
                                          ),
                                          const Column(
                                            children: [
                                              Text(
                                                "€ 8",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue),
                                              ),
                                              Text("90 min",
                                                  style: TextStyle(
                                                      color: Colors.blue))
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(35, 80, 35, 0),
                                  child: GFButton(
                                    onPressed: () {
                                      setState(() {
                                        var match = PadelMatch(
                                            date: DateTime(
                                                pickedDate.year,
                                                pickedDate.month,
                                                pickedDate.day,
                                                (selectedTime / 60).floor(),
                                                selectedTime % 60),
                                            owner: widget.user);

                                        widget.db.createMatch(
                                            widget.club, match,
                                            isPublic: true);

                                        reserved = refreshTimeslots();
                                      });
                                    },
                                    color: Colors.blue.shade700,
                                    shape: GFButtonShape.pills,
                                    boxShadow: BoxShadow(
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                        color: Colors.grey.shade700),
                                    child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 10),
                                          Text("Reserveer de eerste plaats")
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Reserveer een privé baan",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  "In een privé reservering kunnen enkel spelers meedoen die je uitnodigt")
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: GFButton(
                            onPressed: () {
                              (reservedSlots[selectedSlot + 1] ||
                                      reservedSlots[selectedSlot + 2])
                                  ? null
                                  : setState(() {
                                      var match = PadelMatch(
                                          date: DateTime(
                                              pickedDate.year,
                                              pickedDate.month,
                                              pickedDate.day,
                                              (selectedTime / 60).floor(),
                                              selectedTime % 60),
                                          owner: widget.user);
                                      widget.club.matches.add(match);

                                      reserved = refreshTimeslots();

                                      widget.logger
                                          .d(widget.club.matches.toString());
                                      widget.db.createMatch(widget.club, match);
                                    });
                            },
                            color: (reservedSlots[selectedSlot + 1] ||
                                    reservedSlots[selectedSlot + 2])
                                ? Colors.grey
                                : const Color.fromARGB(255, 0, 20, 20),
                            fullWidthButton: true,
                            child: const Text(
                              "Create match (90 min)",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator(
                      color: Color.fromARGB(255, 0, 20, 20),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  SizedBox timePicker(BuildContext context, List<bool> reservedSlots) {
    List<int> slots = [];
    for (int i = 0; i < 30; i++) {
      slots.add(480 + i * 30);
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: GridView.count(
          crossAxisCount: 6,
          childAspectRatio: 30 / 24,
          children: slots.map(
            (slot) {
              return GridTile(
                child: InkWell(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: (!reservedSlots[((slot - 480) / 30).floor()])
                      ? () {
                          if (!reservedSlots[((slot - 480) / 30).floor()]) {
                            setState(() {
                              selectedTime = slot;
                              widget.logger.d(
                                  "Selected: ${(slot / 60).floor().toString().padLeft(2, '0')}:${(slot % 60).toString().padLeft(2, '0')} ($slot)");
                            });
                          }
                        }
                      : null,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: (selectedTime != slot)
                          ? (!reservedSlots[((slot - 480) / 30).floor()])
                              ? Colors.white
                              : Colors.grey
                          : const Color.fromARGB(255, 0, 20, 20),
                    ),
                    child: Center(
                      child: Text(
                        "${(slot / 60).floor().toString().padLeft(2, '0')}:${(slot % 60).toString().padLeft(2, '0')}",
                        style: TextStyle(
                            color: (selectedTime == slot)
                                ? Colors.white
                                : const Color.fromARGB(255, 0, 20, 20)),
                      ),
                    ),
                  ),
                ),
              );
            },
          ).toList()),
    );
  }

  SizedBox datePicker(BuildContext context) {
    return SizedBox(
      height: 120,
      width: MediaQuery.of(context).size.width - 150,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: dates.length,
          itemBuilder: (ctx, i) {
            return InkWell(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => setState(() {
                pickedDate = dates[i];
                widget.logger.d("Picked date: ${dates[i]}");
                selectedTime = 480;

                setState(() {
                  reserved = refreshTimeslots();
                });
              }),
              child: Container(
                margin: const EdgeInsets.all(6),
                padding: const EdgeInsets.all(6),
                width: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getWeekday(dates[i].weekday),
                      style: const TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.none,
                          color: Color.fromARGB(255, 0, 20, 20)),
                    ),
                    Container(
                      height: 40,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (pickedDate.day == dates[i].day)
                              ? const Color.fromARGB(255, 0, 20, 20)
                              : Colors.white),
                      child: Center(
                        child: Text(dates[i].day.toString(),
                            style: TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.none,
                                color: (pickedDate.day == dates[i].day)
                                    ? Colors.white
                                    : const Color.fromARGB(255, 0, 20, 20))),
                      ),
                    ),
                    Text(getMonth(dates[i].month),
                        style: const TextStyle(
                            fontSize: 12,
                            decoration: TextDecoration.none,
                            color: Color.fromARGB(255, 0, 20, 20))),
                  ],
                ),
              ),
            );
          }),
    );
  }

  String getWeekday(int dayoftheweek) {
    switch (dayoftheweek) {
      case 1:
        return "MA";
      case 2:
        return "DI";
      case 3:
        return "WO";
      case 4:
        return "DO";
      case 5:
        return "VR";
      case 6:
        return "ZA";
      case 7:
        return "ZO";

      default:
        return "XX";
    }
  }

  String getMonth(int dayoftheweek) {
    switch (dayoftheweek) {
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
