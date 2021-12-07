import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_cubit/data/model/weather.dart';
import 'package:weather_cubit/data/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {

  final WeatherRepository _weatherRepository;

  WeatherCubit(this._weatherRepository) : super(WeatherInitial());

  Future<void> getWeather(String cityName) async{
    try{
      emit(WeatherLoading());
      final weather = await _weatherRepository.fetchWeather(cityName);
      emit(WeatherLoaded(weather));
    } on NetworkException {
      emit(WeatherError("couldent fetch weather . Is the device online?"));
    }
  }
}
