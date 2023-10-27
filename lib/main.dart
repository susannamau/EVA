import 'package:flutter/material.dart';
import 'Home.dart';
import 'package:app/OrariNavi.dart';
import 'Vento_DB.dart';
import 'EventiPage.dart';
import 'NightLifePage.dart';
import 'GuardiaMedica.dart';
import 'DevelopmentInfoPage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ElbaVivaApp());
}

class ElbaVivaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ELBAVIVA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Structure(),
    );
  }
}

class Structure extends StatefulWidget {
  @override
  _StructureState createState() => _StructureState();
}

class _StructureState extends State<Structure> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    OrariNavi(),
    Vento(),
    Eventi(),
    NightLife(),
  ];
  final List<String> _titles = [
    'Welcome to ELBAVIVA',
    'Orari',
    'Vento',
    'Eventi',
    'Night Life',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_currentIndex],
          style: TextStyle(
            color: Colors.white, //colore del titolo in alto
          ),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                // Apri il drawer
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Text(
                  'ElbaViva❤️‍🔥',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.local_hospital),
              title: Text('Guardia medica'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GuardiaMedica()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Informazioni sullo sviluppo dell\'app'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DevelopmentInfoPage()),
                );
              },
            ),
            // Aggiungi altri elementi qui
          ],
        ),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: NavigationBar(
        destinations: <Widget>[
          NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home'),
          NavigationDestination(
              selectedIcon: Icon(Icons.directions_boat),
              icon: Icon(Icons.directions_boat_outlined),
              label: 'Orari'),
          NavigationDestination(
              selectedIcon: Icon(Icons.air),
              icon: Icon(Icons.air_outlined),
              label: 'Vento'),
          NavigationDestination(
              selectedIcon: Icon(Icons.event),
              icon: Icon(Icons.event_outlined),
              label: 'Eventi'),
          NavigationDestination(
              selectedIcon: Icon(Icons.nightlife),
              icon: Icon(Icons.nightlife_outlined),
              label: 'Locali'),
        ],
        selectedIndex: _currentIndex,
        //indicatorColor: Colors.blue,
        indicatorShape: CircleBorder(),
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
