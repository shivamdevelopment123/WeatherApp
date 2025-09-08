part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class WeatherSearched extends WeatherEvent {
  final String city;
  const WeatherSearched(this.city);

  @override
  List<Object> get props => [city];
}

class WeatherRefreshed extends WeatherEvent {
  final Place place;
  const WeatherRefreshed(this.place);

  @override
  List<Object> get props => [place];
}
