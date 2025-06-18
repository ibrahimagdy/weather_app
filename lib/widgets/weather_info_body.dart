import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherInfoBody extends StatelessWidget {
  final WeatherModel weather;

  const WeatherInfoBody({super.key, required this.weather});

  Color _getWeatherColor(String condition) {
    final cond = condition.toLowerCase();
    if (cond.contains('sunny') || cond.contains('clear')) {
      return Colors.orange;
    } else if (cond.contains('rain')) {
      return Colors.blue.shade700;
    } else if (cond.contains('snow')) {
      return Colors.lightBlue.shade300;
    } else if (cond.contains('cloud')) {
      return Colors.grey.shade600;
    } else if (cond.contains('thunder')) {
      return Colors.deepPurple;
    } else {
      return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final weatherColor = _getWeatherColor(weather.weatherCondition);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: isDark ? Colors.grey[900] : Colors.grey[100],
      child: Stack(
        children: [
          Positioned(
            right: 20,
            top: 100,
            child: Opacity(
              opacity: 0.3,
              child: Icon(
                _getWeatherIcon(weather.weatherCondition),
                size: 200,
                color: weatherColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      weather.city,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    Container(
                      height: 3,
                      width: 100,
                      color: weatherColor,
                      margin: const EdgeInsets.only(top: 8),
                    ),
                  ],
                ),
                Text(
                  "Updated at ${weather.lastUpdated.hour.toString().padLeft(2, '0')}:${weather.lastUpdated.minute.toString().padLeft(2, '0')}",
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 32),
                Card(
                  color: isDark ? Colors.black87 : Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: weatherColor.withValues(alpha: 0.3),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.network(
                              "https:${weather.image}",
                              width: 80,
                              height: 80,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  _getWeatherIcon(weather.weatherCondition),
                                  size: 60,
                                  color: weatherColor,
                                );
                              },
                            ),
                            Column(
                              children: [
                                Text(
                                  "${weather.temp.round()}°",
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: weatherColor,
                                  ),
                                ),
                                Text(
                                  weather.weatherCondition,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color:
                                        isDark ? Colors.white : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.arrow_upward, size: 16),
                                    Text(
                                      "${weather.maxTemp.round()}°",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.arrow_downward, size: 16),
                                    Text(
                                      "${weather.minTemp.round()}°",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildWeatherInfoItem(
                              context,
                              Icons.access_time,
                              "Last Updated",
                              "${weather.lastUpdated.hour}:${weather.lastUpdated.minute}",
                              weatherColor,
                            ),
                            _buildWeatherInfoItem(
                              context,
                              Icons.wb_sunny,
                              "Condition",
                              weather.weatherCondition,
                              weatherColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherInfoItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
        ),
      ],
    );
  }

  IconData _getWeatherIcon(String condition) {
    final cond = condition.toLowerCase();
    if (cond.contains('sunny') || cond.contains('clear')) {
      return Icons.wb_sunny;
    } else if (cond.contains('rain')) {
      return Icons.beach_access;
    } else if (cond.contains('snow')) {
      return Icons.ac_unit;
    } else if (cond.contains('cloud')) {
      return Icons.cloud;
    } else if (cond.contains('thunder')) {
      return Icons.flash_on;
    } else {
      return Icons.wb_cloudy;
    }
  }
}