import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final DateTime time;
  final double temperatureC;
  final double feelsLikeC;
  final int humidity;
  final bool isDay;
  final double precipitationMm;
  final double windSpeedKph;
  final int weatherCode;


  const Weather({
    required this.time,
    required this.temperatureC,
    required this.feelsLikeC,
    required this.humidity,
    required this.isDay,
    required this.precipitationMm,
    required this.windSpeedKph,
    required this.weatherCode,
  });


  factory Weather.fromOpenMeteo(Map<String, dynamic> json) {
    final current = json['current'] as Map<String, dynamic>;
    return Weather(
      time: DateTime.parse(current['time'] as String).toLocal(),
      temperatureC: (current['temperature_2m'] as num).toDouble(),
      feelsLikeC: (current['apparent_temperature'] as num).toDouble(),
      humidity: (current['relative_humidity_2m'] as num).toInt(),
      isDay: (current['is_day'] as num) == 1,
      precipitationMm: (current['precipitation'] as num).toDouble(),
      windSpeedKph: ((current['wind_speed_10m'] as num).toDouble()),
      weatherCode: (current['weather_code'] as num).toInt(),
    );
  }


  @override
  List<Object?> get props => [
    time,
    temperatureC,
    feelsLikeC,
    humidity,
    isDay,
    precipitationMm,
    windSpeedKph,
    weatherCode,
  ];
}