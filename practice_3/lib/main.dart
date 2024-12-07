import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WSApi {
  final String url;
  final String apiKey;
  WSApi(this.url, this.apiKey);
  Future<Map<String, dynamic>>  getWeatherCity(String city) async {
    var responce = await http.get(
        Uri.parse('$url/current?access_key=$apiKey&query=$city'));
    if (responce.statusCode==200) {
        return json.decode(responce.body);
    } else {
      throw Exception('Ошибка ввода города');  }
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
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blueGrey,
        scaffoldBackgroundColor: Color(0xFFFFF8E1),
      ),
      home:
      const MyHomePage(title: 'Weather'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _city = TextEditingController();
  final WSApi _api = WSApi('http://api.weatherstack.com', '4bf58b2ee069822c7ed103d23fe364e3');
  String _weatherInfo = '';
  bool _isLoading = false;
  String _gifPath = 'assets/sticker.gif';

  Future<void> _fetchWeather() async {
    if (_city.text.trim().isEmpty) {
      setState(() {
        _weatherInfo = 'Введите название города';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _weatherInfo = '';
      _gifPath = 'assets/sticker.gif';
    });

    try {
      final data = await _api.getWeatherCity(_city.text);
      String weatherDescription = data['current']['weather_descriptions'][0];
      if (weatherDescription.contains('Rain')) {
        _gifPath = 'assets/rain.gif';
      } else if (weatherDescription.contains('Clear')) {
        _gifPath = 'assets/sun.gif';
      } else if (weatherDescription.contains('Cloud')) {
        _gifPath = 'assets/wind_1.gif';
      } else if (weatherDescription.contains('Snow')) {
        _gifPath = 'assets/snow.gif';
      } else{
        _gifPath = 'assets/sticker.gif';
      }
      setState(() {
        _weatherInfo = 'Температура: ${data['current']['temperature']}°C\n'
            'Погода: ${weatherDescription}';
      });
    } catch (e) {
      setState(() {
        _weatherInfo = 'Ошибка ввода города';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8E1),
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            TextField(
              controller: _city,
              decoration: InputDecoration(
                labelText: 'Введите город',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16,),
            ElevatedButton(onPressed: _fetchWeather, child: const Text("Получить погоду")),
            const SizedBox(height: 16),
            if (_isLoading)
              const CircularProgressIndicator()
            else
              Text(
                _weatherInfo,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),

            SizedBox(

                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.4,
                child: Image.asset(
                  _gifPath,
                  fit: BoxFit.cover,
                ),
            ),
          ],
        )
      )
    );
  }
}