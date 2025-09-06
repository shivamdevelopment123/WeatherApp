import 'package:equatable/equatable.dart';
import 'package:weatherapp/models/place.dart';
import 'package:weatherapp/models/weather.dart';

class CityWeather extends Equatable {
  final Place place;
  final Weather weather;

  const CityWeather({required this.place, required this.weather});

  @override
  List<Object?> get props => [place, weather];
}