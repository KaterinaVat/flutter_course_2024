import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api_key.dart';

Future<Map<String, dynamic>> fetchWeather(String city) async {
  var response = await http.get(Uri.parse('http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city&aqi=no'));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load weather data');
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MeteoAkper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();
  Map<String, dynamic> _weatherData = {};
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MeteoAkper'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                hintText: 'Введите город',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (_cityController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Пожалуйста, введите название города')),
                  );
                } else {
                  setState(() {
                    _isLoading = true;
                  });
                  try {
                    final weatherData = await fetchWeather(_cityController.text);
                    setState(() {
                      _weatherData = weatherData;
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Город не найден')),
                    );
                  } finally {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                }
              },
              child: const Text('Узнать погоду'),
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_weatherData.isNotEmpty)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text('Город: ${_weatherData['location']['name']}'),
                        Text('Температура: ${_weatherData['current']['temp_c']}°C'),
                        Text('Погода: ${_weatherData['current']['condition']['text']}'),
                        Image.network(
                          'http://cdn.weatherapi.com/weather/64x64/day/${_weatherData['current']['condition']['icon'].split('/').last}',
                        ),
                      ],
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}