import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
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
  late Future<List<int>> timeslots;

  @override
  void initState() {
    for (int i = 0; i < 60; i++) {
      dates.add(DateTime.now().add(Duration(days: i)));
    }
    timeslots = refreshTimeslots();
    super.initState();
  }

  /// Gets the matches that have been booked for the day the user selected,
  /// and makes the corresponding timeslots unavailable;
  Future<List<int>> refreshTimeslots() async {
    widget.logger.d("Refreshing timeslots");

    var slots = List<int>.empty(growable: true);
    return await widget.db
        .getMatchesByDate(widget.club.id, pickedDate)
        .then((taken) {
      for (int i = 0; i < 30; i++) {
        slots.add(480 + i * 30);
      }

      if (taken.isNotEmpty) {
        widget.logger.d("Checking retrieved matches");
        for (PadelMatch match in taken) {
          int start =
              (((match.date.hour * 60 + match.date.minute) - 480) / 30).floor();
          int end = start + ((match.duration / 30).floor());
          slots.setRange(start, end, List.filled(end, 0));
        }
      }

      widget.logger.d(taken);

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
                future: timeslots,
                builder: (ctx, snap) {
                  if (snap.hasData) {
                    return timePicker(ctx, snap.data!);
                  } else {
                    return const CircularProgressIndicator(
                      color: Color.fromARGB(255, 0, 20, 20),
                    );
                  }
                }),
            Container(
              padding: const EdgeInsets.all(20),
              child: GFButton(
                onPressed: () => setState(() {
                  var match = PadelMatch(
                      date: DateTime(
                          pickedDate.year,
                          pickedDate.month,
                          pickedDate.day,
                          (selectedTime / 60).floor(),
                          selectedTime % 60),
                      owner: widget.user);
                  widget.club.matches.add(match);

                  setState(() {
                    timeslots = refreshTimeslots();
                  });
                  widget.logger.d(widget.club.matches.toString());
                  widget.db.createMatch(widget.club, match);
                }),
                color: const Color.fromARGB(255, 0, 20, 20),
                fullWidthButton: true,
                child: const Text(
                  "Create match (90 min)",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  SizedBox timePicker(BuildContext context, List<int> timeslots) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 350,
      child: GridView.count(
          crossAxisCount: 6,
          childAspectRatio: 30 / 24,
          children: timeslots.map(
            (slot) {
              return GridTile(
                child: InkWell(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    if (slot != 0) {
                      setState(() {
                        selectedTime = slot;
                        widget.logger.d(
                            "Selected: ${(slot / 60).floor().toString().padLeft(2, '0')}:${(slot % 60).toString().padLeft(2, '0')} ($slot)");
                      });
                    }
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: (selectedTime != slot)
                          ? (slot != 0)
                              ? Colors.white
                              : Colors.red
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
                  timeslots = refreshTimeslots();
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
