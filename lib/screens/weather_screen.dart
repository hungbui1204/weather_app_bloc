import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app_bloc/blocs/theme_bloc.dart';
import 'package:weather_app_bloc/blocs/weather_bloc.dart';
import 'package:weather_app_bloc/events/theme_event.dart';
import 'package:weather_app_bloc/events/weather_event.dart';
import 'package:weather_app_bloc/model/weather_model.dart';
import 'package:weather_app_bloc/screens/city_search_screen.dart';
import 'package:weather_app_bloc/screens/settings_screen.dart';
import 'package:weather_app_bloc/state/theme_state.dart';
import 'package:weather_app_bloc/state/weather_state.dart';
import 'package:weather_app_bloc/widget/temp_widget.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text('Weather Today'),
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
                        builder: (context) => const CitySearchScreen()));
                if (typedCity != null) {
                  BlocProvider.of<WeatherBloc>(context)
                      .add(WeatherEventRequested(city: typedCity));
                }
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: BlocConsumer<WeatherBloc, WeatherState>(
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
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  weather.location,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: themesState.textColor),
                                ),
                                Text(
                                  ' (${weather.nation})',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: themesState.textColor),
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                weather.state,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: themesState.textColor),
                              ),
                              Text(
                                ' (${weather.description})',
                                style: TextStyle(color: themesState.textColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: LottieBuilder.network(
                              Weather.mapWeatherConditionToIcon(
                                  weather.state, weather.lastUpdated),
                              repeat: true,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2)),
                          Center(
                            child: Text(
                              'Update: ${TimeOfDay.fromDateTime(weather.lastUpdated).format(context)}',
                              style: TextStyle(
                                  fontSize: 16, color: themesState.textColor),
                            ),
                          ),
                          TemperatureWidget(weather: weather),
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
                'Something went wrong, please try again',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Please add location',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              SizedBox(
                  height: 350,
                  child: Image.asset(
                    'assets/imgs/umbrella.jpg',
                    fit: BoxFit.fill,
                  )),
            ],
          );
        },
      ),
    );
  }
}
