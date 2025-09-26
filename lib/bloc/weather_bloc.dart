import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
      on<FetchWeather>((event, emit) async {
        try{
          final apiKey = dotenv.env['API_KEY'];
          WeatherFactory wf = WeatherFactory("$apiKey", language: Language.ENGLISH);

          double latitude = event.position.latitude;
          double longitude =event.position.longitude;

          Weather weather = await wf.currentWeatherByLocation(latitude, longitude);

          if (kDebugMode) {
            print(weather);
          }
          emit(WeatherSuccess(weather));
        }catch (e){
          emit(WeatherFailure());
        }
      });
  }
}
