import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/API/weather_repository.dart';
import 'package:weather_app_bloc/events/weather_event.dart';
import 'package:weather_app_bloc/model/weather_model.dart';
import 'package:weather_app_bloc/state/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({required this.weatherRepository}) : super(WeatherStateInitial());

  Stream<WeatherState> mapEventToState(WeatherEvent weatherEvent) async* {
    if (weatherEvent is WeatherEventRequested) {
      yield WeatherStateLoading();
      try {
        final Weather weather =
            await weatherRepository.getWeatherFromCity(weatherEvent.city);
        yield WeatherStateSuccess(weather: weather);
      } catch (exception) {
        yield WeatherStateFailure();
      }
    } else if (weatherEvent is WeatherEventRefresh) {
      try {
        final Weather weather =
            await weatherRepository.getWeatherFromCity(weatherEvent.city);
        yield WeatherStateSuccess(weather: weather);
      } catch (exception) {
        yield WeatherStateFailure();
      }
    }
  }
}
