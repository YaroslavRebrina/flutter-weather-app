import 'package:flutter/material.dart';
import 'package:flutter_weather_app/components/home_buttons.dart';
import 'package:flutter_weather_app/components/search_bar.dart';
import 'package:flutter_weather_app/components/weather_bar.dart';
import 'package:flutter_weather_app/main.dart';

import 'package:flutter_weather_app/services/weather_service.dart';

import 'package:flutter_weather_app/services/weather_sevice_api.dart';

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
    weatherFuture = loadWeatherData(userCity: userCity);
  }

  void handleSearch(String city) async {
    if (city.isEmpty) {
      return;
    }

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
                  try {
                    final temp = box.get('temp');
                    final city = box.get('city');
                    final weatherName = box.get('weatherName');
                    return WeatherBar(
                      weatherName: weatherName,
                      userCity: city,
                      celsium: temp,
                    );
                  } catch (e) {
                    return const Text(
                        'City not exist or you made a mistake ;)');
                  }
                } else if (snapshot.hasData) {
                  return WeatherBar(
                    weatherName: snapshot.data?.weatherName,
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
      floatingActionButton: const HomeButtons(),
    );
  }
}
