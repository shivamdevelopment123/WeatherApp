import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/core/failures.dart';
import 'package:weatherapp/data/repository/weather_repository.dart';
import 'package:weatherapp/models/city_weather.dart';
import 'package:weatherapp/models/place.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;
  WeatherBloc({required this.repository}) : super(const WeatherInitial()) {
    on<WeatherSearched>(_onSearched);
    on<WeatherRefreshed>(_onRefreshed);
  }

  Future<void> _onSearched(WeatherSearched event, Emitter<WeatherState> emit) async {
    if(event.city.trim().isEmpty) return;
    emit(const WeatherLoading());
    try{
      final data = await repository.getByCity(event.city.trim());
      emit(WeatherLoaded(data));
    }on Failure catch(e){
      emit(WeatherError(e.message));
    }
  }

  Future<void> _onRefreshed(WeatherRefreshed event, Emitter<WeatherState> emit) async {
    emit(const WeatherLoading());
    try {
      final data = await repository.refresh(event.place);
      emit(WeatherLoaded(data));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
