import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
  final String state;
  final String nation;
  final WeatherCondition weatherCondition;
  final String description;
  final double minTemp;
  final double maxTemp;
  final double temp;
  final String location;
  final int id;
  final DateTime lastUpdated;
  const Weather(
      {required this.weatherCondition,
      required this.state,
      required this.nation,
      required this.description,
      required this.minTemp,
      required this.maxTemp,
      required this.temp,
      required this.location,
      required this.id,
      required this.lastUpdated});
  factory Weather.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    return Weather(
        weatherCondition: mapStringToWeatherCondition(weather['main'] ?? ''),
        state: weather['main'] ?? '',
        nation: json['sys']['country'],
        description: weather['description'] ?? '',
        minTemp: json['main']['temp_min'] as double,
        maxTemp: json['main']['temp_max'] as double,
        temp: json['main']['temp'] as double,
        location: json['name'] ?? '',
        id: json['id'] ?? 0,
        lastUpdated: DateTime.now());
  }
  static String mapWeatherConditionToIcon(
      String weatherCondition, DateTime dateTime) {
    Map<String, List<String>> map = {
      'Clear': [
        'https://lottie.host/11e121dd-d5bd-4d9a-8f2a-c20ee6f71e41/wC60CJeuDj.json',
        'https://lottie.host/ea74ad27-8af6-4b3c-bae0-870f2ee25d1d/uG3pZoL48C.json'
      ],
      'Clouds': [
        'https://lottie.host/9bb1dfd0-80e5-43c3-9781-538788cdcfee/P7tIssZjoJ.json',
        'https://lottie.host/5436cc65-8468-4062-8834-3d8928635256/lgRO9xxfc2.json'
      ],
      'Rain': [
        'https://lottie.host/9a388e77-30b7-4e6d-90af-9d212380b3ab/jhffag9D9L.json',
        'https://lottie.host/44e7e96a-36fd-4fe0-9aa2-ab39e601fea3/DGAmCPtasi.json'
      ]
    };
    if (dateTime.hour <= const TimeOfDay(hour: 18, minute: 0).hour) {
      return map[weatherCondition]?[0] ?? '';
    } else {
      return map[weatherCondition]?[1] ?? '';
    }
  }

  static WeatherCondition mapStringToWeatherCondition(String inputString) {
    Map<String, WeatherCondition> map = {
      'Clear': WeatherCondition.clear,
      'Clouds': WeatherCondition.clouds,
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
