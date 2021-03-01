import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';
class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather,this.foreCastData});
  final locationWeather;
  final foreCastData;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
 var typedName;
  String cityName;
  String weatherIcon;
  int temperature;
  String message;


  var windSpeed;
  int hourlyWeatherId;
  var visibility;
  var clouds;
  var forecastMessage;
  WeatherModel weatherModel=WeatherModel();
  @override
  void initState() {

    super.initState();
      print(widget.foreCastData);
    updateUI(widget.locationWeather);
    updateForecast(widget.foreCastData);
  }
  void updateForecast(dynamic foreCastData){

    setState(() {
      if(foreCastData==null){
        windSpeed=0.0;
        forecastMessage='unable to reach weather data';
        clouds=0.0;
        visibility=0;
        return;
      }
      windSpeed=foreCastData['current']['wind_speed'];
      visibility=foreCastData['current']['visibility'];
      clouds=foreCastData['current']['clouds'];
       hourlyWeatherId=foreCastData['hourly'][10]['weather'][0]['id'];

       print(hourlyWeatherId);

      forecastMessage='Today windSpeed is:$windSpeed,visibility is:$visibility,clouds is:$clouds --id :$hourlyWeatherId';
    });


  }

  void updateUI(dynamic weatherData){
    setState(() {
      if(weatherData==null){
        temperature=0;
        weatherIcon='Error';
        message='unable to reach weather data';
        cityName='no access';
        return;
      }

      double temp=weatherData['main']['temp'];
      temperature=temp.toInt();
      print(temp);
      int condition=weatherData['weather'][0]['id'];
      cityName= weatherData['name'];
      weatherIcon=weatherModel.getWeatherIcon(condition);
      message=weatherModel.getMessage(temperature);
    });

  }
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                     var weatherData= await weatherModel.getLocationWeather();
                     var foreCastData= await weatherModel.getWeatherDataForecast();
                     updateUI(weatherData);
                     updateForecast(foreCastData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: ()async{
                      typedName= await Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>CityScreen()
                        ),
                     );
                      if(typedName!=null){
                       var weatherData= await weatherModel.getWeatherByCity(typedName);
                       updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$message in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
          Padding(
            padding: EdgeInsets.only(right: 1.0),
            child: Text(
              forecastMessage,
              textAlign: TextAlign.right,
              style: kMessageTextStyle,
                )),
            ],
          ),
        ),
      ),
    );
  }
}
