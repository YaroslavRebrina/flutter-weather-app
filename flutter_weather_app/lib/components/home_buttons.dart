import 'package:flutter/material.dart';
import 'package:flutter_weather_app/pages/weather_details.dart';
import 'package:flutter_weather_app/utils/provider.dart';
import 'package:provider/provider.dart';

class HomeButtons extends StatelessWidget {
  const HomeButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: Consumer<UnitsNotifier>(
            // Use Consumer here
            builder: (context, unitsNotifier, child) {
              return ElevatedButton(
                child: Text(unitsNotifier.uintsEnum == UnitType.metric
                    ? 'Metric'
                    : 'Farenheit'),
                onPressed: () {
                  unitsNotifier.toggleUnits();
                },
              );
            },
          ),
        ),
        // Spacing between buttons
        Positioned(
          bottom: 0,
          right: 0,
          child: ElevatedButton(
            child: const Text('Go to weather forecast'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WeatherDetails(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
