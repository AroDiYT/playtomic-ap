import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Booking extends StatefulWidget {
  Logger logger;

  Booking({super.key, required this.logger});

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  var pickedDate = DateTime.now();
  late List<DateTime> dates;

  @override
  void initState() {
    dates = List.empty(growable: true);
    for (int i = 0; i < 60; i++) {
      dates.add(DateTime.now().add(Duration(days: i)));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
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
                SizedBox(
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
                                      color: (pickedDate == dates[i])
                                          ? const Color.fromARGB(255, 0, 20, 20)
                                          : Colors.white),
                                  child: Center(
                                    child: Text(dates[i].day.toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            decoration: TextDecoration.none,
                                            color: (pickedDate == dates[i])
                                                ? Colors.white
                                                : const Color.fromARGB(
                                                    255, 0, 20, 20))),
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
                ),
              ],
            )
          ],
        ),
      ),
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
