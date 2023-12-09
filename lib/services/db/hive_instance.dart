import 'package:flutter_weather_app/main.dart';

void putBox(
    {required double temp, required String city, required String weatherName}) {
  box.putAll({'temp': temp, "city": city, 'weatherName': weatherName});
}
