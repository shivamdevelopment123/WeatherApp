import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/core/failures.dart';
import 'package:weatherapp/models/place.dart';

class WeatherApiClient{
  static const _geoBase = 'https://geocoding-api.open-meteo.com/v1/search';
  static const _weatherBase = 'https://api.open-meteo.com/v1/forecast';

  final http.Client client;
  WeatherApiClient({http.Client? client}) : client = client ?? http.Client();

  Future<Place> geocode(String city) async {
    final url = Uri.parse('$_geoBase?.name=${Uri.encodeQueryComponent(city)}');
    final response = await client.get(url);
    if(response.statusCode != 200){
      throw const Failure('Geocoding failed');
    }
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final results = body['results'] as List<dynamic>;
    if(results.isEmpty){
      throw const Failure('No results found');
    }
    final first = results.first as Map<String, dynamic>;
    return Place.fromJson(first);
  }

  Future<Map<String, dynamic>> fetchCurrentWeather({required double lat, required double lon}) async{
    final params = {
      'latitude': lat.toString(),
      'longitude': lon.toString(),
      'current_weather': 'temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,weather_code,is_day,wind_speed_10m',
      'timezone': 'auto',
    };
    final uri = Uri.parse(_weatherBase).replace(queryParameters: params);
    final res = await client.get(uri);
    if (res.statusCode != 200) {
      throw const Failure('Weather fetch failed');
    }
    return jsonDecode(res.body) as Map<String, dynamic>;

  }
}