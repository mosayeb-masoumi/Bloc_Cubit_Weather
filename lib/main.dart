import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_cubit/cubit/weather_cubit.dart';
import 'package:weather_cubit/data/weather_repository.dart';
import 'package:weather_cubit/pages/weather_search_page.dart';

// https://www.youtube.com/watch?v=y564ETOCog8   source
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => WeatherCubit(FakeWeatherRepository()),
          child: const WeatherSearchPage()),
    );
  }
}
