import 'package:flutter_weather_app/services/db/hive_instance.dart';
import 'package:flutter_weather_app/services/geolocation_service.dart';
import 'package:flutter_weather_app/services/weather_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import 'package:flutter_weather_app/main.dart';

Future<Location> getLocation({required String city}) async {
  final urlCordinates = Uri.parse(
      "http://api.openweathermap.org/geo/1.0/direct?q=$city&limit=1&units=${unitsNotifier.units}&appid=$API_KEY");

  final response = await http.get(urlCordinates);
  if (response.statusCode == 200) {
    var decodedData = jsonDecode(response.body);

    var locationData = decodedData[0];

    final result = Location.fromJson(locationData);

    return result;
  } else {
    throw Exception('Failed to load location data');
  }
}

Future<WeatherResponse> getWeather({
  required String city,
}) async {
  final Location data = await getLocation(city: city);

  final lon = data.lon;
  final lat = data.lat;

  var urlWeather = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=${unitsNotifier.units}&appid=$API_KEY');

  final response = await http.get(urlWeather);
  final decodedData = jsonDecode(response.body);
  final result = WeatherResponse.fromJson(decodedData);
  putBox(temp: result.temp, city: city, weatherName: result.weatherName);
  return result;
}

Future<WeatherItemList> getWeatherForecast({
  required String city,
}) async {
  final Location data = await getLocation(city: city);

  final lon = data.lon;
  final lat = data.lat;

  var urlWeather = Uri.parse(
      'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&units=${unitsNotifier.units}&appid=$API_KEY');

  final response = await http.get(urlWeather);
  final decodedData = jsonDecode(response.body);

  return WeatherItemList.fromJson(decodedData);
}

Future<WeatherResponse?> loadWeatherData({String? userCity}) async {
  final positionOnRender = await getCurrentPosition();

  if (positionOnRender != null) {
    var urlWeather = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${positionOnRender.latitude}&lon=${positionOnRender.longitude}&units=${unitsNotifier.units}&appid=$API_KEY');

    final response = await http.get(urlWeather);
    final decodedData = jsonDecode(response.body);
    final result = WeatherResponse.fromJson(decodedData);

    putBox(
        temp: result.temp,
        city: userCity ?? '',
        weatherName: result.weatherName);
    return result;
  }
  return null;
}
