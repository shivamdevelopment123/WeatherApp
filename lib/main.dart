import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/bloc/weather_bloc.dart';
import 'package:weatherapp/data/data_provider/weather_data_provider.dart';
import 'package:weatherapp/data/repository/weather_repository.dart';
import 'package:weatherapp/screens/weather_screen.dart';

void main() {
  final repo = WeatherRepository(apiClient: WeatherApiClient());

  runApp(BlocProvider(
    create: (context) => WeatherBloc(repository: repo),
    child: const MyApp(),
  )
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
      ),
      home: WeatherScreen(),
    );
  }
}
