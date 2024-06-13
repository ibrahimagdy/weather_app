class WeatherModel {
  final String city;
  final DateTime lastUpdated;
  final String image;
  final double temp;
  final double maxTemp;
  final double minTemp;
  final String weatherCondition;

  WeatherModel(
      {required this.city,
      required this.lastUpdated,
      required this.image,
      required this.temp,
      required this.maxTemp,
      required this.minTemp,
      required this.weatherCondition});

  factory WeatherModel.fromJson(json) {
    return WeatherModel(
      city: json["location"]["name"],
      lastUpdated: DateTime.parse(json["current"]["last_updated"]),
      image: json["forecast"]["forecastday"][0]["day"]["condition"]["icon"],
      temp: json["forecast"]["forecastday"][0]["day"]["avgtemp_c"],
      maxTemp: json["forecast"]["forecastday"][0]["day"]["maxtemp_c"],
      minTemp: json["forecast"]["forecastday"][0]["day"]["mintemp_c"],
      weatherCondition: json["forecast"]["forecastday"][0]["day"]["condition"]
          ["text"],
    );
  }
}
