import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/view_model/cubits/get_weather_cubit/weather_states.dart';

import '../../../core/network_layer/api_manger.dart';

class GetWeatherCubit extends Cubit<WeatherStates> {
  GetWeatherCubit() : super(WeatherInitialState());

  WeatherModel? weatherModel;

  getWeather({required String cityName}) async {
    emit(WeatherLoadedState());
    try {
      weatherModel = await ApiManger(Dio()).getWeather(cityName: cityName);
      emit(WeatherSuccessState(weatherModel!));
    } catch (e) {
      emit(WeatherFailureState());
    }
  }
}
