import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app_bloc/model/weather_model.dart';

const baseUrl = 'https://api.openweathermap.org';
const apiKey = '9b43447f27e35c849ed0de44856a7902';
final locationUrl =
    (city) => '${baseUrl}/data/2.5/weather?q=${city}&appid=${apiKey}';
final idUrl = (id) => '${baseUrl}/data/2.5/weather?id=${id}&appid=${apiKey}';

class WeatherRepository {
  // Future<Weather>? getCurrentWeather(String location) async {
  //   String url =
  //       'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=c6f2d9e1a71f3ad159c8a4c97bf5578e';
  //   var endpoint = Uri.parse(url);
  //   var response = await http.get(endpoint);
  //   var body = jsonDecode(response.body);
  //   return Weather.fromJson(body);
  // }
  final http.Client httpClient;
  WeatherRepository({
    required this.httpClient,
  });
  Future<Weather> getWeatherFromCity(String city) async {
    final response = await httpClient.get(Uri.parse(locationUrl(city)));
    if (response.statusCode == 200) {
      final weather = jsonDecode(response.body);
      return Weather.fromJson(weather);
    } else {
      throw Exception('Error getting weather info of: ${city}');
    }
  }
}
