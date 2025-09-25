import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) {
      on<FetchWeather>((event, emit) async {
        try{
          WeatherFactory wf = WeatherFactory("", language: Language.ENGLISH);

          Position position = await Geolocator.getCurrentPosition();
          double latitude = position.latitude;
          double longitude = position.longitude;

          Weather weather = await wf.currentWeatherByLocation(latitude, longitude);

          emit(WeatherSuccess(weather));
        }catch (e){
          emit(WeatherFailure());
        }
      });
    });
  }
}
