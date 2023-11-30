import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:intl/intl.dart';

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

class FerryList {
  final DateTime date;
  List<Ferry> naviDelGiorno;
  FerryList({required this.date, required this.naviDelGiorno});
}

class Ferry {
  final String luogo_partenza;
  final String luogo_arrivo;
  final DateTime date;
  final DateTime time_partenza;
  final DateTime time_arrivo;
  final String company;
  Ferry({required this.date, required this.time_partenza, required this.time_arrivo, required this.luogo_partenza, required this.luogo_arrivo, required this.company});
  @override
  String toString() {
    return "| $date, $time_partenza, $time_arrivo, $luogo_partenza, $luogo_arrivo, $company |";
  }
}

DateTime importaDaFormatoSusanna(String s){
  DateFormat format = DateFormat("HH.mm");
  return format.parse(s);
}

class OrariNavi extends StatefulWidget {
  const OrariNavi({super.key});
  @override
  State<OrariNavi> createState() => _OrariNaviState();
}

class _OrariNaviState extends State<OrariNavi> {
  DatabaseReference database =
      FirebaseDatabase.instance.ref('navi').orderByKey().ref;
  var navi;
  var data;
  List<FerryList> navi_all = [];

  @override
  void initState() {
    fetchData();
    print("database type: ");
    print(database.toString());
    print(data.runtimeType);
    print(navi.runtimeType);
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
          navi_all.add(FerryList(date: datekey, naviDelGiorno: []));
          for (var v in value) {
            print("printingV");
            print(v);
            navi_all[index]
                .naviDelGiorno
                .add(Ferry(date: datekey,
                time_partenza: importaDaFormatoSusanna(v['time_partenza']),
                time_arrivo: importaDaFormatoSusanna(v['time_arrivo']),
                luogo_partenza:v['luogo_partenza'],
                luogo_arrivo: v['luogo_arrivo'],
                company: v['company']));
          }
          index++;
        });
      });
      navi_all.sort((a, b) => a.date.compareTo(b.date));
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
                text: "To Elba",
                icon: Icon(Icons.directions_ferry),
              ),
              Tab(
                text: "From Elba",
                icon: Icon(Icons.directions_ferry),
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
                slivers: navi_all.map((ferryList) {
                  return SliverStickyHeader(
                    header: Container(
                      height: 50.0,
                      color: Colors.grey[200],
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: Center(
                        child: Text(
                          '${printableDay(ferryList.date)} '
                              '${ferryList.date.day.toString().padLeft(2, '0')}-'
                              '${ferryList.date.month.toString().padLeft(2, '0')}-'
                              '${ferryList.date.year}',
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
                          title:
                          Text(ferryList.naviDelGiorno[i].luogo_partenza,
                          ),
                          subtitle:
                          Text(ferryList.naviDelGiorno[i].luogo_arrivo),
                          onTap: () {
                            _showFerryInfo(context, 'Informazioni specifiche sulla tratta qui');
                          },
                        ),
                        childCount: ferryList.naviDelGiorno.length,
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
void _showFerryInfo(BuildContext context, String locale) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Informazioni sulla tratta'),
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
