import 'package:flutter_weather_app/services/weather_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

Future<Location> getLocation({required String city}) async {
  final urlCordinates = Uri.parse(
      "http://api.openweathermap.org/geo/1.0/direct?q=$city&limit=1&units=metric&appid=$API_KEY");

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
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$API_KEY');

  final response = await http.get(urlWeather);
  final decodedData = jsonDecode(response.body);
  var weatherData = decodedData['main'];

  final weather = WeatherResponse.fromJson(weatherData);

  return weather;
}
