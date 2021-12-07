part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {
  const WeatherState();
}

// initialize
class WeatherInitial extends WeatherState {
  const WeatherInitial();
}

// loading
class WeatherLoading extends WeatherState{
  const WeatherLoading();
}


// loaded
class WeatherLoaded extends WeatherState{
  final Weather weather;
  const WeatherLoaded(this.weather);


  //alt/insert -> ==() and hashCode
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherLoaded &&
          runtimeType == other.runtimeType &&
          weather == other.weather;

  @override
  int get hashCode => weather.hashCode;
}


// Error
class WeatherError extends WeatherState{
  final String message;
  const WeatherError(this.message);

  //alt/insert -> ==() and hashCode
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherError &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}
