import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_cubit/cubit/weather_cubit.dart';
import 'package:weather_cubit/data/model/weather.dart';

class WeatherSearchPage extends StatefulWidget {
  const WeatherSearchPage({Key? key}) : super(key: key);

  @override
  _WeatherSearchPageState createState() => _WeatherSearchPageState();
}

class _WeatherSearchPageState extends State<WeatherSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Search"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,

        // implement with cubit

        child: BlocConsumer<WeatherCubit, WeatherState>(
            listener: (context, state) {
          // to show snackbar widget because we can not use widget inside builder
          if (state is WeatherError) {
            // we can use widget here directly in listener but in builder as we can see above we can not use widget inside
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        }, builder: (context, state) {
          if (state is WeatherInitial) {
            return buildInitialInput();
          } else if (state is WeatherLoading) {
            return buildLoading();
          } else if (state is WeatherLoaded) {
            return buildColumnWithData(state.weather);
          } else {
            // we can not use widget here directly  but in listener as we can see above we can use widget inside
            return buildInitialInput();
          }
        }),

        // child: BlocBuilder<WeatherCubit , WeatherState>(
        //     builder: (context , state){
        //       if(state is WeatherInitial){
        //         return buildInitialInput();
        //       }else if(state is WeatherLoading){
        //         return buildLoading();
        //       }else if(state is WeatherLoaded){
        //         return buildColumnWithData(state.weather);
        //       }else{
        //         return buildInitialInput();
        //       }
        //     }
        // ),
      ),
    );
  }

  Widget buildInitialInput() {
    return Center(
      child: CityInputField(),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weather.cityName,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          // Display the temperature with 1 decimal place
          "${weather.temperatureCelsius.toStringAsFixed(1)} °C",
          style: TextStyle(fontSize: 80),
        ),
        CityInputField(),
      ],
    );
  }
}

class CityInputField extends StatelessWidget {
  const CityInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => submitCityName(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a city",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  void submitCityName(BuildContext context, String cityName) {
    // get weather for the city
    //   final weatheCubit = context.bloc<WeatherCubit>();
    final weatheCubit = BlocProvider.of<WeatherCubit>(context);
    weatheCubit.getWeather(cityName);
  }
}
