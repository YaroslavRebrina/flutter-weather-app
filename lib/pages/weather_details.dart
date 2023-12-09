// Define the WeatherDetails page (you can expand this as needed)
import 'dart:convert';

import 'package:flutter_weather_app/main.dart';

import 'package:flutter_weather_app/utils/time_parser.dart';

import '../constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/components/search_bar.dart';
import 'package:flutter_weather_app/components/weather_bar.dart';
import 'package:flutter_weather_app/services/geolocation_service.dart';
import 'package:flutter_weather_app/services/weather_service.dart';
import 'package:flutter_weather_app/services/weather_sevice_api.dart';
import 'package:http/http.dart' as http;

class WeatherDetails extends StatefulWidget {
  const WeatherDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<WeatherDetails> createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails> {
  Future<WeatherItemList?>? weatherFuture;
  String? userCity;

  @override
  void initState() {
    super.initState();
    weatherFuture = _loadWeatherForecastData();
  }

  Future<WeatherItemList?>? _loadWeatherForecastData() async {
    final positionOnRender = await getCurrentPosition();

    if (positionOnRender != null) {
      var urlWeather = Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?lat=${positionOnRender.latitude}&lon=${positionOnRender.longitude}&units=${unitsNotifier.units}&appid=$API_KEY');

      final response = await http.get(urlWeather);
      final decodedData = jsonDecode(response.body);

      return WeatherItemList.fromJson(decodedData);
    }
    return null;
  }

  void handleSearch(String city) async {
    setState(() {
      userCity = city;
      weatherFuture = getWeatherForecast(city: city);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Weather forecast'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 100),
            SizedBox(
                width: 400, child: SearchBarWeather(onSearch: handleSearch)),
            const SizedBox(height: 100),
            Text(
              userCity ?? '',
              style: const TextStyle(fontSize: 28.00, color: Colors.blueGrey),
            ),
            FutureBuilder<WeatherItemList?>(
              future: weatherFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('City not exist or you made a mistake ;)');
                } else if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.separated(
                      itemCount: snapshot.data!.list.length,
                      itemBuilder: (context, index) {
                        final item = snapshot.data!.list[index];
                        return WeatherBar(
                          date: formatDate(item.dt),
                          celsium: item.main.temp,
                          weatherName: item.weather[0].main,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height:
                              1, // You can adjust the height for a thicker or thinner line
                          color:
                              Colors.grey, // Choose a color for the separator
                        );
                      },
                    ),
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
