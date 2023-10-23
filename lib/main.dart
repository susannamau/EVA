import 'package:flutter/material.dart';
import 'Home.dart';
import 'package:app/OrariNavi.dart';
import 'Vento.dart';
import 'EventiPage.dart';
import 'NightLifePage.dart';
import 'DevelopmentInfoPage.dart';

void main() => runApp(ElbaVivaApp());

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
              child: Text('Menu Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Aggiorna il contenuto dell'app quando viene selezionato l'elemento
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Dev'),
              onTap: () {
                // Aggiorna il contenuto dell'app quando viene selezionato l'elemento
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
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_time),
              label: 'Orari'),
          BottomNavigationBarItem(
              icon: Icon(Icons.air),
              label: 'Vento'),
          BottomNavigationBarItem(
              icon: Icon(Icons.event),
              label: 'Eventi'),
          BottomNavigationBarItem(
              icon: Icon(Icons.nightlife),
              label: 'Night Life'),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        //showUnselectedLabels: true,
        unselectedLabelStyle: TextStyle(
          color: Colors.white,
        ),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
// QUI INIZIA CODICE PER MENU LATERALE
