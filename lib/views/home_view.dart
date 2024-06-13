import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/view_model/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/views/search_view.dart';
import 'package:weather_app/widgets/no_weather_body.dart';
import 'package:weather_app/widgets/weather_info_body.dart';

import '../view_model/cubits/get_weather_cubit/weather_states.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const SearchView();
                    },
                  ),
                );
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: BlocBuilder<GetWeatherCubit, WeatherStates>(
          builder: (context, state) {
        if (state is WeatherLoadedSuccessState) {
          return WeatherInfoBody(
            weatherModel: state.weatherModel,
          );
        } else if (state is WeatherInitialState) {
          return const NoWeatherBody();
        } else {
          return const Center(
            child: Text('oops, There was an error'),
          );
        }
      }),
    );
  }
}
