import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/blocs/theme_bloc.dart';
import 'package:weather_app_bloc/blocs/weather_bloc.dart';
import 'package:weather_app_bloc/events/theme_event.dart';
import 'package:weather_app_bloc/events/weather_event.dart';
import 'package:weather_app_bloc/screens/city_search_screen.dart';
import 'package:weather_app_bloc/screens/settings_screen.dart';
import 'package:weather_app_bloc/state/theme_state.dart';
import 'package:weather_app_bloc/state/weather_state.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreen();
}

class _WeatherScreen extends State<WeatherScreen> {
  late Completer<void> _completer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _completer = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App Using Bloc'),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()));
            },
            icon: const Icon(Icons.settings),
          ),
          IconButton(
              onPressed: () async {
                final typedCity = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CitySearchScreen()));
                if (typedCity != null) {
                  BlocProvider.of<WeatherBloc>(context)
                      .add(WeatherEventRequested(city: typedCity));
                }
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, weatherState) {
            if (weatherState is WeatherStateSuccess) {
              BlocProvider.of<ThemeBloc>(context).add(ThemeEventWeatherChanged(
                  weatherCondition: weatherState.weather.weatherCondition));
              _completer.complete();
              _completer = Completer();
            }
          },
          builder: (context, weatherState) {
            if (weatherState is WeatherStateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (weatherState is WeatherStateSuccess) {
              final weather = weatherState.weather;
              return BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, themesState) {
                return RefreshIndicator(
                  onRefresh: () {
                    BlocProvider.of<WeatherBloc>(context)
                        .add(WeatherEventRefresh(city: weather.location));
                    //return a completer obj
                    return _completer.future;
                  },
                  child: Container(
                    color: themesState.backgroundColor,
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            Text(
                              weather.location,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: themesState.textColor),
                            ),
                            const Padding(
                                padding: EdgeInsets.symmetric(vertical: 2)),
                            Center(
                              child: Text(
                                'Update: ${TimeOfDay.fromDateTime(weather.lastUpdated).format(context)}',
                                style: TextStyle(
                                    fontSize: 16, color: themesState.textColor),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
            }
            if (weatherState is WeatherStateFailure) {
              return const Center(
                child: Text(
                  'Something went wrong',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            }
            return const Center(
              child: Text(
                'Select a location first',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
