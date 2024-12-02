import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  var temperatura = '';
  var temp2 = '';
  var umidade = '';
  var umid2 = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Latitude',
                  ),
                ),
                const SizedBox(height: 10),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Longitude',
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: getTemperatura,
                  child: const Text('Buscar'),
                ),
                const SizedBox(height: 10),
                Text(
                  'Temperatura atual: $temperatura',
                  style: const TextStyle(fontSize: 25),
                ),
                const SizedBox(height: 10),
                Text(
                  'Umidade atual: $umidade',
                  style: const TextStyle(fontSize: 25),
                ),
                const SizedBox(height: 10),
                Text(
                  'Temperatura por hora: $temp2',
                  style: const TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 10),
                Text(
                  'Umidade por hora: $umid2',
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getTemperatura() async {
    final latitude = double.tryParse(_latitudeController.text) ?? 0.0;
    final longitude = double.tryParse(_longitudeController.text) ?? 0.0;

    final uri = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current=temperature_2m,relative_humidity_2m&hourly=temperature_2m,relative_humidity_2m&forecast_days=1');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final dados = jsonDecode(response.body);
      final temperatura = dados['current']['temperature_2m'];
      final temp2 = dados['hourly']['temperature_2m'];
      final umidade = dados['current']['relative_humidity_2m'];
      final umid2 = dados['hourly']['relative_humidity_2m'];
      setState(() {
        this.temperatura = '$temperatura °C';
        this.umidade = '$umidade';
        this.temp2 = '$temp2 °C';
        this.umid2 = '$umid2';
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }
}
