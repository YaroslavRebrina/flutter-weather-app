import 'package:flutter/material.dart';
import 'package:flutter_weather_app/pages/home_page.dart';
import 'package:flutter_weather_app/services/db/weather_instance.dart';
import 'package:flutter_weather_app/utils/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

late UnitsNotifier unitsNotifier;
late Box box;
Future<void> main() async {
  await Hive.initFlutter();
  box = await Hive.openBox('box');
  Hive.registerAdapter(WeatherInstanceAdapter());
  unitsNotifier = UnitsNotifier.instance;
  runApp(
    ChangeNotifierProvider(
      create: (context) => UnitsNotifier.instance,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Weather App'),
    );
  }
}
