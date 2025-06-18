import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view_model/providers/theme_provider.dart';

class NoWeatherBody extends StatelessWidget {
  const NoWeatherBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDark = themeProvider.isDarkMode;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.wb_sunny_outlined,
                  size: 64,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
                const SizedBox(height: 16),
                Text(
                  'No weather data available 😔',
                  style: TextStyle(
                    fontSize: 24,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Getting your location... 🔍',
                  style: TextStyle(
                    fontSize: 18,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}