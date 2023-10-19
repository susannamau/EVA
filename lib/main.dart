import 'package:flutter/material.dart';
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
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .center, // Centra gli elementi verticalmente nella colonna
          children: <Widget>[
            // Scritta centrata
            Text(
              'Welcome to ElbaViva',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            // Spaziatura tra la scritta e l'immagine
            SizedBox(height: 20), // Puoi regolare l'altezza come preferisci

            // Immagine centrata
            Image.asset('images/logo-trasp.png'),
          ],
        ),
      ),
    );
  }
}

class OrariScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Orari'),
    );
  }
}

class VentoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Vento'),
    );
  }
}

class EventiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Eventi'),
    );
  }
}

class NightLifeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('Night Life\n\nqui metteremo la lista delle serate'));
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    WelcomeScreen(),
    OrariScreen(),
    VentoScreen(),
    EventiScreen(),
    NightLifeScreen(),
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
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_time), label: 'Orari'),
          BottomNavigationBarItem(icon: Icon(Icons.air), label: 'Vento'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Eventi'),
          BottomNavigationBarItem(
              icon: Icon(Icons.nightlife), label: 'Night Life'),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
