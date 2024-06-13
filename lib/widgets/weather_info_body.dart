import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherInfoBody extends StatelessWidget {
  final WeatherModel weatherModel;

  const WeatherInfoBody({super.key, required this.weatherModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            weatherModel.city,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
          Text(
            "Updated at ${weatherModel.lastUpdated.hour}:${weatherModel.lastUpdated.minute}",
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                "https:${weatherModel.image}",
              ),
              Text(
                weatherModel.temp.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              Column(
                children: [
                  Text(
                    "MaxTemp: ${weatherModel.maxTemp.round()}",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "MinTemp: ${weatherModel.minTemp.round()}",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            weatherModel.weatherCondition,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
        ],
      ),
    );
  }
}
