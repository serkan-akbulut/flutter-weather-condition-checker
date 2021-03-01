
import 'package:flutter/material.dart';

import 'package:clima/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {


  @override
  void initState() {
    super.initState();
    getLocationData();

  }
  void getLocationData ()async{

        WeatherModel weatherModel=WeatherModel();

      var weatherData= await weatherModel.getLocationWeather();
      var foreCastData= await weatherModel.getWeatherDataForecast();
    Navigator.push(context, MaterialPageRoute(builder:(context)=>LocationScreen(locationWeather: weatherData,foreCastData: foreCastData,)));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(
       child: SpinKitDoubleBounce(
        color: Colors.white,
         size: 100,
       ),
     ),
    );
  }
}
