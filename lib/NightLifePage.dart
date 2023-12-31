//import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

String printableDay(DateTime d) {
  switch (d.weekday) {
    case 1:
      return "Monday";
    case 2:
      return "Tuesday";
    case 3:
      return "Wednesday";
    case 4:
      return "Thursday";
    case 5:
      return "Friday";
    case 6:
      return "Saturday";
    case 7:
      return "Sunday";
    default:
      return "Invalid day";
  }
}

class EventList {
  final DateTime date;
  List<Event> eventiDelGiorno;
  EventList({required this.date, required this.eventiDelGiorno});
}

class Event {
  final String locale;
  final String genere;
  Event({required this.locale, required this.genere});
  @override
  String toString() {
    return "| $locale, $genere |";
  }
}

class NightLife extends StatefulWidget {
  const NightLife({super.key});
  @override
  State<NightLife> createState() => _NightLifeState();
}

class _NightLifeState extends State<NightLife> {
  DatabaseReference database =
      FirebaseDatabase.instance.ref('serate').orderByKey().ref;
  var eventi;
  var data;
  List<EventList> calendar = [];

  @override
  void initState() {
    fetchData();
    print("database type: ");
    print(database.toString());
    print(data.runtimeType);
    print(eventi.runtimeType);
    super.initState();
  }

  fetchData() async {
    try {
      //DatabaseEvent event = await database.child('serate').once(); //in caso si può rimuovere il child
      //DatabaseEvent event = await database.once();
      DataSnapshot data1 = await database.get();
      setState(() {
        //data = event.snapshot.value;
        data = data1.value;
        //print("tip di data");
        //print(data.runtimeType);
        int index = 0;
        data.forEach((key, value) {
          DateTime datekey = DateTime.parse(key);
          calendar.add(EventList(date: datekey, eventiDelGiorno: []));
          for (var v in value) {
            calendar[index]
                .eventiDelGiorno
                .add(Event(locale: v['locale'], genere: v['genere']));
          }
          index++;
        });
      });
      calendar.sort((a, b) => a.date.compareTo(b.date));
    } catch (e) {
      print("Errore durante il fetch dei dati: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Build method");
    print(data);
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const TabBar(
            unselectedLabelColor: Colors.white54,
            indicator: UnderlineTabIndicator(
              //borderSide: BorderSide(color: Color(0xDD613896), width: 8.0),
              insets: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 10.0),
            ),
            tabs: <Widget>[
              Tab(
                text: 'Ristoranti',
                icon: Icon(Icons.restaurant),
              ),
              Tab(
                text: 'Locali',
                icon: Icon(Icons.nightlife),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: Text("It's cloudy here"),
            ),
            Center(
              child: data == null
                  ? CircularProgressIndicator()
                  : CustomScrollView(
                      slivers: calendar.map((eventList) {
                        return SliverStickyHeader(
                          header: Container(
                            height: 50.0,
                            color: Colors.grey[200],
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            alignment: Alignment.centerLeft,
                            child: Center(
                              child: Text(
                                '${printableDay(eventList.date)} '
                                '${eventList.date.day.toString().padLeft(2, '0')}-'
                                '${eventList.date.month.toString().padLeft(2, '0')}-'
                                '${eventList.date.year}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, i) => ListTile(
                                leading: Icon(Icons.music_note),
                                title: Text(
                                  eventList.eventiDelGiorno[i].locale,
                                ),
                                subtitle:
                                    Text(eventList.eventiDelGiorno[i].genere),
                                onTap: () {
                                  _showLocaleInfo(context, 'Informazioni specifiche del locale qui');
                                },
                              ),
                              childCount: eventList.eventiDelGiorno.length,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
void _showLocaleInfo(BuildContext context, String locale) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Informazioni sul locale'),
        content: Text(locale),
        actions: <Widget>[
          TextButton(
            child: Text('Chiudi'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
