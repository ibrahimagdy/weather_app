import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view_model/providers/theme_provider.dart';
import 'package:weather_app/view_model/providers/weather_provider.dart';
import 'package:weather_app/views/home_view.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Weather App',
            themeMode: themeProvider.themeMode,
            theme: ThemeData.light(
              useMaterial3: true,
            ).copyWith(
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              scaffoldBackgroundColor: Colors.grey[50],
            ),
            darkTheme: ThemeData.dark(
              useMaterial3: true,
            ).copyWith(
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.blue[800],
                foregroundColor: Colors.white,
              ),
              scaffoldBackgroundColor: Colors.grey[900],
            ),
            debugShowCheckedModeBanner: false,
            home: const HomeView(),
          );
        },
      ),
    );
  }
}