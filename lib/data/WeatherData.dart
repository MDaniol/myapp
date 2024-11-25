class WeatherData {
  final double temperature2m;
  final double relativeHumidity2m;
  final int weatherCode;
  final double surfacePressure;

  WeatherData({
    required this.temperature2m,
    required this.relativeHumidity2m,
    required this.weatherCode,
    required this.surfacePressure,
  });

  // Factory method to create an instance from JSON
  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temperature2m: json['current']['temperature_2m'].toDouble(),
      relativeHumidity2m:
          json['current']['relative_humidity_2m'].toDouble(),
      weatherCode: json['current']['weather_code'],
      surfacePressure: json['current']['surface_pressure'].toDouble(),
    );
  }
}
