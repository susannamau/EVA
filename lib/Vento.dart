import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

String direzioneVento(int gradi) {
  if (gradi >= 337.5 || gradi < 22.5) return 'Tramontana';
  if (gradi >= 22.5 && gradi < 67.5) return 'Grecale';
  if (gradi >= 67.5 && gradi < 112.5) return 'Levante';
  if (gradi >= 112.5 && gradi < 157.5) return 'Scirocco';
  if (gradi >= 157.5 && gradi < 202.5) return 'Mezzogiorno o Ostro';
  if (gradi >= 202.5 && gradi < 247.5) return 'Libeccio';
  if (gradi >= 247.5 && gradi < 292.5) return 'Ponente';
  if (gradi >= 292.5 && gradi < 337.5) return 'Maestrale';

  return 'Direzione non valida'; // per gradi non compresi tra 0 e 360
}

void main() {
  int gradi = 45; // Esempio di valore di input
  print(direzioneVento(gradi));
}

class Weather {
  final int windDirection;
  final double windSpeed;
  final double temperature;
  final int humidity;
  final DateTime sunsetTime;
  Weather({
    required this.windDirection,
    required this.windSpeed,
    required this.temperature, // it is assumed in Celsius here
    required this.humidity,
    required this.sunsetTime,
  });
  @override
  String toString() {
    return 'C\'è vento di: ${direzioneVento(windDirection)},\nad una velocità di ${windSpeed} nodi,\n'
        'ci sono: ${temperature.toStringAsFixed(2)} gradi,\n'
        'con un ${humidity}% di umidità,\n'
        'il sole tramonta alle: ${sunsetTime.hour + 12}:${sunsetTime.minute}';
  }
}

class Vento extends StatefulWidget {
  const Vento({super.key});

  @override
  State<Vento> createState() => _VentoState();
}

class _VentoState extends State<Vento> {
  DatabaseReference database = FirebaseDatabase.instance.ref('weather');
  var data;
  List<Weather> listaMeteo = [];

  @override
  void initState() {
    super.initState();
    fetchData();
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
        print(data['visibility']);
        listaMeteo.add(Weather(
          windDirection: data['wind']['deg'],
          windSpeed: data['wind']['speed'],
          temperature: ((data['main']['temp'] as double) -
              273.15),
          // it is assumed in Celsius here
          humidity: data['main']['humidity'],
          sunsetTime: DateTime.fromMillisecondsSinceEpoch(
              1000 * (data['sys']['sunrise']) as int),
          // va convertito da absolute a time e visualizzato solo come time
        ));
      });
    } catch (e) {
      print("Errore durante il fetch dei dati: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    print('lista meteo length: ${listaMeteo.length}');
    listaMeteo.forEach((element) {
      print(element);
    });
    return Scaffold(
        appBar: AppBar(
          title: Text("Firebase Realtime Database"),
        ),
        body: Center(
          child: listaMeteo.length==0 ?
          CircularProgressIndicator(
          ) :
          Text(
            listaMeteo[0].toString(),
            textAlign: TextAlign.justify,
          ),
        ));
  }
}