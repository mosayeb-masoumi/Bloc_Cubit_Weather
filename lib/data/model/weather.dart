import 'package:meta/meta.dart';
class Weather{

  final String cityName ;
  final double temperatureCelsius;

  Weather({
    required this.cityName,
    required this.temperatureCelsius,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Weather &&
          runtimeType == other.runtimeType &&
          cityName == other.cityName &&
          temperatureCelsius == other.temperatureCelsius;

  @override
  int get hashCode => cityName.hashCode ^ temperatureCelsius.hashCode;

}