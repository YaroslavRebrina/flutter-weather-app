import 'package:flutter/material.dart';

class WeatherBar extends StatelessWidget {
  final double? celsium;
  final String? userCity;
  final String? weatherName;
  final String? date;

  const WeatherBar(
      {super.key,
      this.celsium = 0.0,
      this.userCity,
      this.weatherName,
      this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          userCity ?? '',
          style: const TextStyle(fontSize: 20),
        ),
        Text(date ?? ''),
        Text(
          "$weatherName | ${celsium.toString()}°C",
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
