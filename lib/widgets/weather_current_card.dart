import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/core/weather_code_map.dart';
import 'package:weatherapp/models/city_weather.dart';

class WeatherCurrentCard extends StatelessWidget {
  final CityWeather data;
  const WeatherCurrentCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    
    final w = data.weather;
    final p = data.place;
    final isDay = w.isDay;
    final icon = WeatherCodeMap.icon(w.weatherCode, isDay);
    final description = WeatherCodeMap.description(w.weatherCode);
    return Card(
      child: Padding(padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${data.place.name}${data.place.country != null ? ', ' + data.place.country! : ''}',
                  ),
                  const SizedBox(height: 8,),
                  Text(DateFormat('EEE, d MMM • HH:mm').format(w.time)),
                ],
              ),
              Icon(icon, size: 64,),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                '${w.temperatureC.toStringAsFixed(1)}°C',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(width: 12),
              Text(description, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              _Chip(icon: Icons.thermostat, label: 'Feels ${w.feelsLikeC.toStringAsFixed(1)}°C'),
              _Chip(icon: Icons.water_drop, label: 'Humidity ${w.humidity}%'),
              _Chip(icon: Icons.air, label: 'Wind ${w.windSpeedKph.toStringAsFixed(1)} km/h'),
              _Chip(icon: Icons.invert_colors, label: 'Precip ${w.precipitationMm.toStringAsFixed(1)} mm'),
              _Chip(icon: isDay ? Icons.wb_sunny : Icons.nights_stay, label: isDay ? 'Day' : 'Night'),
            ],
          ),
        ],
      ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Chip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
    );
  }
}
