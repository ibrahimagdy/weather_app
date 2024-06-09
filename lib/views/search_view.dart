import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/core/network_layer/api_manger.dart';
import 'package:weather_app/models/weather_model.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            onSubmitted: (value) async {
              weatherModel = await ApiManger(Dio()).getWeather(cityName: value);
              log(weatherModel!.city);
              Navigator.pop(context);
            },
            decoration: const InputDecoration(
                labelText: 'Search',
                hintText: 'Enter city name',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                )),
          ),
        ),
      ),
    );
  }
}

WeatherModel? weatherModel;
