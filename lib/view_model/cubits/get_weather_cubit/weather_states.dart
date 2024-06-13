import 'package:weather_app/models/weather_model.dart';

class WeatherStates {}

class WeatherInitialState extends WeatherStates {}

class WeatherLoadedSuccessState extends WeatherStates {
  final WeatherModel weatherModel;

  WeatherLoadedSuccessState(this.weatherModel);
}

class WeatherFailureState extends WeatherStates {}
