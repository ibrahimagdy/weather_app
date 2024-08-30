import 'package:weather_app/models/weather_model.dart';

class WeatherStates {}

class WeatherInitialState extends WeatherStates {}

class WeatherLoadedState extends WeatherStates {}

class WeatherSuccessState extends WeatherStates {
  final WeatherModel weatherModel;

  WeatherSuccessState(this.weatherModel);
}

class WeatherFailureState extends WeatherStates {}
