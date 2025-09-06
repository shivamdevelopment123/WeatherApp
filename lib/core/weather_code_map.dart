
import 'package:flutter/material.dart';

class WeatherCodeMap{
  static String description(int code){
    if(code == 0) return 'Clear Sky';
    if ([1, 2, 3].contains(code)) return 'Partly cloudy';
    if ([45, 48].contains(code)) return 'Fog';
    if ([51, 53, 55, 56, 57].contains(code)) return 'Drizzle';
    if ([61, 63, 65, 66, 67].contains(code)) return 'Rain';
    if ([71, 73, 75, 77].contains(code)) return 'Snow';
    if ([80, 81, 82].contains(code)) return 'Rain showers';
    if ([85, 86].contains(code)) return 'Snow showers';
    if ([95, 96, 99].contains(code)) return 'Thunderstorm';
    return 'Unknown';
  }

  static IconData icon(int code, bool isDay) {
    if (code == 0) return isDay ? Icons.wb_sunny : Icons.nights_stay;
    if ([1, 2, 3].contains(code)) return Icons.cloud;
    if ([45, 48].contains(code)) return Icons.foggy;
    if ([51, 53, 55, 56, 57].contains(code)) return Icons.grain;
    if ([61, 63, 65, 66, 67, 80, 81, 82].contains(code)) return Icons.umbrella;
    if ([71, 73, 75, 77, 85, 86].contains(code)) return Icons.ac_unit;
    if ([95, 96, 99].contains(code)) return Icons.thunderstorm;
    return Icons.help_outline;
  }
}