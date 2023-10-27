import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';

class NightLife extends StatefulWidget {
  const NightLife({super.key});

  @override
  State<NightLife> createState() => _NightLifeState();
}

class _NightLifeState extends State<NightLife> {
  DatabaseReference database = FirebaseDatabase.instance.ref();
  var data;
  var eventi;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    try {
      DatabaseEvent event = await database.child('serate').once(); //in caso si può rimuovere il child
      setState(() {
        data = event.snapshot.value;
        eventi = json.decode(data);
      });
    } catch (e) {
      print("Errore durante il fetch dei dati: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
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
            ListView.builder(
              itemCount: eventi.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(eventi[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}