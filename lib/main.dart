import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_bloc/API/weather_repository.dart';
import 'package:weather_app_bloc/blocs/settings_bloc.dart';
import 'package:weather_app_bloc/blocs/theme_bloc.dart';
import 'package:weather_app_bloc/blocs/weather_bloc_observer.dart';
import 'package:weather_app_bloc/screens/weather_screen.dart';
import 'package:weather_app_bloc/state/theme_state.dart';

import 'blocs/weather_bloc.dart';

void main() {
  Bloc.observer = WeatherBlocObserver();
  final WeatherRepository weatherRepository =
      WeatherRepository(httpClient: http.Client());
  runApp(MultiBlocProvider(providers: [
    BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
    BlocProvider<SettingsBloc>(create: (context) => SettingsBloc()),
  ], child: MyApp(weatherRepository: weatherRepository)));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.weatherRepository}) : super(key: key);
  final WeatherRepository weatherRepository;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return MaterialApp(
        home: BlocProvider(
          create: (context) =>
              WeatherBloc(weatherRepository: weatherRepository),
          child: WeatherScreen(),
        ),
      );
    });
  }
}
