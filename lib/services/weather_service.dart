import 'package:json_annotation/json_annotation.dart';

part 'weather_service.g.dart';

@JsonSerializable()
class WeatherResponse {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final String weatherName; // New property

  WeatherResponse({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.weatherName, // Initialize the new property
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    var mainData = json['main'];
    var weatherName = json['weather'][0]['main']; // Extracting weather name

    return WeatherResponse(
      temp: mainData['temp'],
      feelsLike: mainData['feels_like'],
      tempMin: mainData['temp_min'],
      tempMax: mainData['temp_max'],
      pressure: mainData['pressure'],
      humidity: mainData['humidity'],
      weatherName: weatherName, // Setting the new property
    );
  }
}

// This file will be generated by json_serializable

@JsonSerializable()
class Location {
  double lat;
  double lon;

  Location({
    required this.lat,
    required this.lon,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class WeatherItemList {
  String cod;
  int message;
  int cnt;
  List<WeatherItem> list;

  WeatherItemList(
      {required this.cod,
      required this.message,
      required this.cnt,
      required this.list});

  factory WeatherItemList.fromJson(Map<String, dynamic> json) =>
      _$WeatherItemListFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherItemListToJson(this);
}

@JsonSerializable()
class WeatherItem {
  int dt;
  Main main;
  List<Weather> weather;

  WeatherItem({required this.dt, required this.main, required this.weather});

  factory WeatherItem.fromJson(Map<String, dynamic> json) =>
      _$WeatherItemFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherItemToJson(this);
}

@JsonSerializable()
class Main {
  double temp;
  double feels_like;

  Main({required this.temp, required this.feels_like});

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);
  Map<String, dynamic> toJson() => _$MainToJson(this);
}

@JsonSerializable()
class Weather {
  int id;
  String main;
  String description;

  Weather({required this.id, required this.main, required this.description});

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}
