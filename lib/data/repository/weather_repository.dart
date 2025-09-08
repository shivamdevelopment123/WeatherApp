import 'package:weatherapp/core/failures.dart';
import 'package:weatherapp/data/data_provider/weather_data_provider.dart';
import 'package:weatherapp/models/city_weather.dart';
import 'package:weatherapp/models/place.dart';
import 'package:weatherapp/models/weather.dart';

class WeatherRepository{
  final WeatherApiClient apiClient;
  WeatherRepository({required this.apiClient});

  Future<CityWeather> getByCity(String city)async{
    try{
      final place = await apiClient.geocode(city);
      final raw = apiClient.fetchCurrentWeather(lat: place.latitude, lon: place.longitude);
      final weather = Weather.fromOpenMeteo(await raw);
      return CityWeather(place: place, weather: weather);
    }on Failure{
      rethrow;
    }catch(e){
      throw const Failure('Something went wrong');
    }
  }

  Future<CityWeather> refresh(Place place) async {
    try {
      final raw = await apiClient.fetchCurrentWeather(lat: place.latitude, lon: place.longitude);
      final weather = Weather.fromOpenMeteo(raw);
      return CityWeather(place: place, weather: weather);
    } on Failure {
      rethrow;
    } catch (_) {
      throw const Failure('Unexpected error refreshing weather');
    }
  }
}