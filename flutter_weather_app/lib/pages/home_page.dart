import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/components/search_bar.dart';
import 'package:flutter_weather_app/components/weather_bar.dart';
import 'package:flutter_weather_app/services/geolocation_service.dart';
import 'package:flutter_weather_app/services/weather_service.dart';

import 'package:flutter_weather_app/services/weather_sevice_api.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<WeatherResponse?>? weatherFuture;
  String? userCity;

  @override
  void initState() {
    super.initState();
    weatherFuture = _loadWeatherData();
  }

  Future<WeatherResponse?> _loadWeatherData() async {
    final positionOnRender = await getCurrentPosition();
    if (positionOnRender != null) {
      var urlWeather = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=${positionOnRender.latitude}&lon=${positionOnRender.longitude}&units=metric&appid=$API_KEY');

      final response = await http.get(urlWeather);
      final decodedData = jsonDecode(response.body);
      var weatherData = decodedData['main'];

      return WeatherResponse.fromJson(weatherData);
    }
    return null;
  }

  void handleSearch(String city) async {
    setState(() {
      userCity = city;
      weatherFuture = getWeather(city: city);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 100),
            SizedBox(
                width: 400, child: SearchBarWeather(onSearch: handleSearch)),
            const SizedBox(height: 100),
            FutureBuilder<WeatherResponse?>(
              future: weatherFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('City not exist or you made a mistake ;)');
                } else if (snapshot.hasData) {
                  return WeatherBar(
                    userCity: userCity,
                    celsium: snapshot.data?.temp,
                  );
                } else {
                  return const Text('No weather data available');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
