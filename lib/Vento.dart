import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Vento extends StatefulWidget {
  const Vento({super.key});

  @override
  State<Vento> createState() => _VentoState();
}

class _VentoState extends State<Vento> {

  DatabaseReference database = FirebaseDatabase.instance.ref("serate");
  var data;

  @override
  void initState() {
    super.initState();
    print(database.once().runtimeType);
    print("fetching");
    fetchData();
  }

  fetchData() async {
    try {
      DatabaseEvent event = await database.once(); //in caso si può rimuovere il child
      setState(() {
        data = event.snapshot.value;
        print("tip di data");
        print(data.runtimeType);
      });
    } catch (e) {
      print("Errore durante il fetch dei dati: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    print('building vento');
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Realtime Database"),
      ),
      body: Center(
        child: data == null ? Text('Non carica') : Text('Dati: $data'),
      ),
    );
  }
}
