import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/network_layer/api_manger.dart';
import 'package:weather_app/models/weather_model.dart';

enum WeatherStatus { initial, loading, success, failure }

class WeatherProvider extends ChangeNotifier {
  WeatherModel? _weatherModel;
  WeatherStatus _status = WeatherStatus.initial;
  String? _errorMessage;
  String? _currentLocationName;

  WeatherModel? get weatherModel => _weatherModel;

  WeatherStatus get status => _status;

  String? get errorMessage => _errorMessage;

  String? get currentLocationName => _currentLocationName;

  final ApiManager _apiManager = ApiManager(Dio());

  Future<void> getCurrentLocationWeather() async {
    _status = WeatherStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception(
            'Location services are disabled. Please enable location services.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            'Location permissions are permanently denied. Please enable location in settings.');
      }
      Position position = await Geolocator.getCurrentPosition();

      try {
        List<Placemark> placeMarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        if (placeMarks.isNotEmpty) {
          final placeMark = placeMarks.first;

          String? cityName = placeMark.locality ??
              placeMark.subAdministrativeArea ??
              placeMark.administrativeArea ??
              placeMark.subLocality;

          if (cityName != null && cityName.isNotEmpty) {
            _currentLocationName = cityName;

            await getWeatherByCity(_currentLocationName!);
          } else {
            _currentLocationName =
                '${position.latitude.toStringAsFixed(2)},${position.longitude.toStringAsFixed(2)}';
            await getWeatherByCity(_currentLocationName!);
          }
        } else {
          _currentLocationName =
              '${position.latitude.toStringAsFixed(2)},${position.longitude.toStringAsFixed(2)}';
          await getWeatherByCity(_currentLocationName!);
        }
      } catch (geocodingError) {
        _currentLocationName =
            '${position.latitude.toStringAsFixed(2)},${position.longitude.toStringAsFixed(2)}';
        await getWeatherByCity(_currentLocationName!);
      }
    } catch (e) {
      _status = WeatherStatus.failure;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> getWeatherByCity(String cityName) async {
    _status = WeatherStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _weatherModel = await _apiManager.getWeather(cityName: cityName);
      _status = WeatherStatus.success;
    } catch (e) {
      _status = WeatherStatus.failure;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }
}
