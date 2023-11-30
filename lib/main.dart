import 'package:flutter/material.dart';
import 'Home.dart';
import 'package:app/OrariNavi.dart';
import 'Vento.dart';
import 'EventiPage.dart';
import 'NightLifePage.dart';
import 'GuardiaMedica.dart';
import 'Supermercati.dart';
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
        primarySwatch: Colors.cyan,
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
            SizedBox(
              height: 310.0,
              child: DrawerHeader(
                child: Center(
                  child: Column(
                    children: [
                      Image.asset('images/Logo/polpo2.png',
                      width: 150,
                      ),
                      Text(
                        'ElbaViva',
                        style: TextStyle(
                          fontFamily: 'Pacifico',
                          color: Colors.black,
                          fontSize: 35,
                        ),
                      )
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.cyan.shade300,
                ),
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
              leading: Icon(Icons.shopping_cart),
              title: Text('Supermercati'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Supermercati()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.developer_mode),
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
