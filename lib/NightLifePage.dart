import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';

class NightLife extends StatefulWidget {
  const NightLife({super.key});

  @override
  State<NightLife> createState() => _NightLifeState();
}

class _NightLifeState extends State<NightLife> {
  DatabaseReference database = FirebaseDatabase
      .instance
      .ref('serate')
      .orderByKey()
      .ref;
  var eventi;
  var data;

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
      print(data1.value);
      setState(() {
        //data = event.snapshot.value;
        data = data1.value;
        print("tip di data");
        print(data.runtimeType);
      });
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
              child: data == null ? Text('Non carica') :
              ListView.builder(
                itemCount: data.entries.length,
                itemBuilder: (context, index) {
                  var date = data.entries.elementAt(index).key;
                  var events = data[date];
                  return ListTile(
                    title: Text(date),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: events.map<Widget>((event) {
                        return ListTile(
                          title:Text('Locale: ${event['locale']}'),
                          subtitle:Text('Genere: ${event['genere']}'),
                        );

                        //    'Locale: ${event['locale']}, Genere: ${event['genere']}');
                      }).toList(),
                    ),
                  );
                },
              )

            )
          ],
            ),
        ),
      );
  }
  }
