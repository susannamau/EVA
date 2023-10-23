import 'package:flutter/material.dart';

class Home extends StatelessWidget {
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