import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/view_model/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/view_model/cubits/get_weather_cubit/weather_states.dart';
import 'package:weather_app/views/home_view.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: BlocBuilder<GetWeatherCubit, WeatherStates>(
        builder: (context, state) {
          final weatherCubit = BlocProvider.of<GetWeatherCubit>(context);
          return MaterialApp(
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                color: getWeatherColor(
                    weatherCubit.weatherModel?.weatherCondition),
              ),
            ),
            debugShowCheckedModeBanner: false,
            home: const HomeView(),
          );
        },
      ),
    );
  }
}

Color getWeatherColor(String? condition) {
  if (condition == null) {
    return Colors.orange;
  }
  switch (condition) {
    case "Sunny":
      return Colors.orange;
    case "Partly cloudy":
      return Colors.blueGrey;
    case "Cloudy":
      return Colors.grey;
    case "Overcast":
      return Colors.blueGrey;
    case "Mist":
      return Colors.lightBlue;
    case "Patchy rain possible":
    case "Light rain":
    case "Moderate rain":
    case "Heavy rain":
      return Colors.blue;
    case "Patchy snow possible":
    case "Light snow":
    case "Moderate snow":
    case "Heavy snow":
      return Colors.lightBlueAccent;
    case "Thundery outbreaks possible":
    case "Moderate or heavy rain with thunder":
    case "Patchy light rain with thunder":
      return Colors.deepPurple;
    case "Fog":
    case "Freezing fog":
      return Colors.grey;
    default:
      return Colors.blueGrey;
  }
}
