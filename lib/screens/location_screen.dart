import 'package:climarun/screens/city_screen.dart';
import 'package:climarun/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:climarun/services/weather.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
  LocationScreen(this.weatherData);
  final weatherData;
}

class _LocationScreenState extends State<LocationScreen> {
  int tempr;
  String wIcon;
  String message;
  String cityName;
  WeatherModel weatherModel = WeatherModel();
  @override
  void initState() {
    getUpdate(widget.weatherData);
    super.initState();
    
  }

  void getUpdate(weatherData) {
    setState(() {
      
    
    if(weatherData==null){
      tempr=0;
      wIcon='Error';
      message='unable to connect or gps is off';
      cityName='';
      return;
    }
    double temp = weatherData['main']['temp'];
    tempr = temp.toInt() - 273;
    var condition = weatherData['weather'][0]['id'];
    print(condition);
    wIcon = weatherModel.getWeatherIcon(condition);
    print(wIcon);
    cityName = weatherData['name'];
    message = weatherModel.getMessage(tempr);
    print(message);
 }); }

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
            
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                     var weatherData= await weatherModel.getWeather();
                     getUpdate(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                      var cityName= await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      },));
                      if(cityName!=null){
                      var weatherData= await weatherModel.getWeatherCity(cityName);
                      getUpdate(weatherData);
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
                padding: EdgeInsets.only(top:80.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$tempr°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      wIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 265.0),
                child: Text(
                  "$message in $cityName !",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
