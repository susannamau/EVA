import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Vento_API extends StatefulWidget {
  const Vento_API({super.key});

  @override
  State<Vento_API> createState() => _Vento_APIState();
}

class _Vento_APIState extends State<Vento_API> {
  Future<Map<String, dynamic>>? _futureData;
  const string url = 'https://api.openweathermap.org/data/2.5/weather?q=Portoferraio&appid=7d471b70796039c73ed0f355cb07bfb3';


  @override
  void initState() {
    super.initState();
    _futureData = fetchData(url);
  }

  fetchData() async {
    try {
      final response = await http.get(Uri.parse(url));
    } catch (e) {
      print("Errore durante il fetch dei dati: $e");
    }
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('API Data Display')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data fetched.'));
          } else {
            Map<String, dynamic> data = snapshot.data!;
            // Customizza la visualizzazione dei dati come preferisci
            return Center(child: Text('Data: ${_futureData.toString()}'));
          }
        },
      ),
    );
  }
}
