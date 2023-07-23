import 'package:equatable/equatable.dart';

enum WeatherCondition {
  clouds,
  rain,
  drizzle,
  clear,
  thunderstorm,
  snow,
  mist,
  smoke,
  haze,
  dust,
  fog,
  sand,
  ash,
  squall,
  tornado,
  unknown
}

class Weather extends Equatable {
  final WeatherCondition? weatherCondition;
  final String? description;
  final double? minTemp;
  final double? maxTemp;
  final double? temp;
  final String? location;
  final int? id;
  const Weather(
      {this.weatherCondition,
      this.description,
      this.minTemp,
      this.maxTemp,
      this.temp,
      this.location,
      this.id});
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        weatherCondition:
            _mapStringToWeatherCondition(json['weather']['main'] ?? ''),
        description: json['weather']['description'] ?? '',
        minTemp: json['main']['temp_min'] as double,
        maxTemp: json['main']['temp']['temp_max'] as double,
        temp: json['main']['temp'] as double,
        location: json['name'] ?? '',
        id: json['id'] as int);
  }
  static WeatherCondition _mapStringToWeatherCondition(String inputString) {
    Map<String, WeatherCondition> map = {
      'Thunderstorm': WeatherCondition.thunderstorm,
      'Drizzle': WeatherCondition.drizzle,
      'Rain': WeatherCondition.rain,
      'Snow': WeatherCondition.snow,
      'Mist': WeatherCondition.mist,
      'Smoke': WeatherCondition.smoke,
      'Haze': WeatherCondition.haze,
      'Dust': WeatherCondition.dust,
      'Fog': WeatherCondition.fog,
      'Sand': WeatherCondition.sand,
      'Ash': WeatherCondition.ash,
      'Squall': WeatherCondition.squall,
      'Tornado': WeatherCondition.tornado
    };
    return map[inputString] ?? WeatherCondition.unknown;
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [weatherCondition, minTemp, maxTemp, temp, temp, location, id];
}
