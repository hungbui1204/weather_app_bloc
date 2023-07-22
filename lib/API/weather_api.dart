import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app_bloc/model/weather_model.dart';

class WeatherApiClient {
  Future<Weather>? getCurrentWeather(String location) async {
    String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=c6f2d9e1a71f3ad159c8a4c97bf5578e';
    var endpoint = Uri.parse(url);
    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    return Weather.fromJson(body);
  }
}
