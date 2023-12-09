// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'weather_instance.g.dart';

@HiveType(typeId: 1)
class WeatherInstance {
  @HiveField(0)
  String city;

  @HiveField(1)
  double temp;

  @HiveField(2)
  double weatherName;

  WeatherInstance({
    required this.city,
    required this.temp,
    required this.weatherName,
  });
}
