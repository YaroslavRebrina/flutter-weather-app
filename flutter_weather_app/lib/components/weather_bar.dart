import 'package:flutter/material.dart';

class WeatherBar extends StatelessWidget {
  final double? celsium;
  final String? userCity;

  const WeatherBar({super.key, this.celsium = 0.0, this.userCity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          userCity ?? '',
          style: const TextStyle(fontSize: 20),
        ),
        Text(
          "${celsium.toString()}°C",
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
