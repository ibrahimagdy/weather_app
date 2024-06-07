import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_model.dart';

class ApiManger {
  final Dio dio;

  ApiManger(this.dio);

  final String baseUrl = 'https://api.weatherapi.com/v1';
  final String apiKey = '3d4a8e59b9cc445587e72629240306';

  Future<WeatherModel?> getWeather({required String cityName}) async {
    try {
      Response response =
          await dio.get('$baseUrl/forecast.json?key=$apiKey&q=$cityName');

      WeatherModel weatherModel = WeatherModel.fromJson(response.data);
      return weatherModel;
    } on DioException catch (e) {
      return null;
    }
  }
}
