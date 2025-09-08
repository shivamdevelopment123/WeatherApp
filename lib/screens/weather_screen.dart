import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/bloc/weather_bloc.dart';
import 'package:weatherapp/widgets/search_bar.dart';
import 'package:weatherapp/widgets/weather_current_card.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: SafeArea(child: Padding(padding:const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CitySearchBar(onSearched: (q){
            context.read<WeatherBloc>().add(WeatherSearched(q));
          }),
          const SizedBox(height: 16,),
          Expanded(child: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state){
            if(state is WeatherInitial){
              return const Center(child: Text('Search a city'),);
            }
            if(state is WeatherLoading){
              return const Center(child: CircularProgressIndicator(),);
            }
            if(state is WeatherError){
              return Center(child: Text(state.message),);
            }
            if(state is WeatherLoaded){
              return RefreshIndicator(child: ListView(
                children: [
                  WeatherCurrentCard(data: state.cityWeather),
                  const SizedBox(height: 16,),
                ],
              ), onRefresh: () async{
                context.read<WeatherBloc>().add(WeatherRefreshed(state.cityWeather.place));
              });
            }
            return const SizedBox();
          }
          )
          )
        ],
      ),
      )
      ),
    );
  }
}
