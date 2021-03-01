import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';


const String apiKey='6e1b7f4fbd9c7ac3fdcc6fdbc61d4b06';
const openWeatherURL='https://api.openweathermap.org/data/2.5/weather';

const foreCastUrl='https://api.openweathermap.org/data/2.5';

class WeatherModel {


  Future<dynamic>getWeatherDataForecast() async{

    Location location=Location();
    await location.getCurrentPosition();
      var url='$foreCastUrl/onecall?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey';
      NetworkHelper networkHelper= NetworkHelper(url: url);
      var foreCastData= await networkHelper.getData();
      return foreCastData;



  }

  Future<dynamic> getWeatherByCity(String cityName) async{
    var url='$openWeatherURL?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper=NetworkHelper(url: url);

    var weatherData= await networkHelper.getData();
    return weatherData;

  }


  Future<dynamic> getLocationWeather() async{
    Location location=Location();
    await location.getCurrentPosition();

    NetworkHelper networkHelper=NetworkHelper(url: '$openWeatherURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData= await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
