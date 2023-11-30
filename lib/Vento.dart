import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';

final GlobalKey imageKey = GlobalKey();

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

class _VentoState extends State<Vento>
  with SingleTickerProviderStateMixin {
  DatabaseReference database = FirebaseDatabase.instance.ref('weather');
  var data;
  List<Weather> listaMeteo = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  late final AnimationController _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds:2)
  )..repeat(reverse: false);

  late final Animation<Offset> _offsetanimation = Tween<Offset>(
    begin: Offset.zero,
    end: Offset(1.5,0),
  ).animate(
    CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,)
  );
  // dispose controller it's mandatory
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
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
        body: Column(
          children: [
            WindMap(windDirection: 45),
            Center(
              child: listaMeteo.length==0 ?
              CircularProgressIndicator(
              ) :
              Text(
                listaMeteo[0].toString(),
                textAlign: TextAlign.justify,
              ),
            ),
            Center(
              child: SlideTransition(
                position: _offsetanimation,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                      Icons.arrow_right,
                      color: Colors.blue,
                      size: 150.0),
                ),
              )
            )
          ],

        ));
  }
}

class WindMap extends StatefulWidget {
  final int windDirection;

  WindMap({required this.windDirection});

  @override
  _WindMapState createState() => _WindMapState();
}

class _WindMapState extends State<WindMap> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  late Animation<double> _translationAnimation;

  double? _imageWidth;
  double? _imageHeight;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _translationAnimation = Tween<double>(begin: 0, end: 50).animate(_controller!);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _getRenderedSize();
    });
  }

  @override
  Widget build(BuildContext context) {

    int rows = 4;
    int columns = 6;
    double desiredCellWidth = 100.0;  // Example width of a cell.
    double desiredCellHeight = 100.0;  // Example height of a cell.

    //columns = ( _imageWidth / desiredCellWidth ).ceil();
    //rows = ( _imageHeight! / desiredCellHeight ).ceil();

    double horizontalSpacing = (_imageWidth ?? 400.0) / (columns + 1);
    double verticalSpacing = (_imageHeight ?? 400.0) / (rows + 1);
    print('W:${_imageWidth}, H:${_imageHeight}');

    List<Widget> arrows = [];



    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        arrows.add(
          Positioned(
            left: (j+0.5) * horizontalSpacing,
            top: (i+1) * verticalSpacing,
            child: AnimatedBuilder(
              animation: _controller!,
              builder: (_, child) {
                double dx = _translationAnimation.value * cos(widget.windDirection.toDouble() * pi / 180);
                double dy = - _translationAnimation.value * sin(widget.windDirection.toDouble() * pi / 180);
                return Transform.translate(
                  offset: Offset(dx, dy),
                  child: Transform.rotate(
                    angle: (widget.windDirection.toDouble() * pi / 180),
                    child: Icon(Icons.arrow_upward, color: Colors.blue, size: 50.0),
                  ),
                );
              },
            ),
          ),
        );
      }
    }

    return Stack(
      children: [
        Image.asset('images/maps/contorno-nero.png',
            fit: BoxFit.cover,
            key: imageKey,
        ),
        ...arrows,
      ],
    );
  }

  void _getRenderedSize() {
    final RenderBox? box = imageKey.currentContext?.findRenderObject() as RenderBox?;
    if (box != null && box.hasSize) {
      final size = box.size;
      setState(() {
        _imageWidth = size.width;
        _imageHeight = size.height;
      });
    }
  }



  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

