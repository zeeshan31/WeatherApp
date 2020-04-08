
import 'package:climarun/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'location_screen.dart';




class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude, longitude;

  void initState() {
    getLocationData();
    super.initState();
  }

  void getLocationData() async {
   var  weatherModel= await WeatherModel().getWeather();
   print(weatherModel);

 Navigator.push(context, MaterialPageRoute(builder: (context){return LocationScreen(weatherModel);}));
  }
  final spinkit = SpinKitFadingCircle(
  itemBuilder: (_, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: index.isEven ? Colors.red : Colors.green,
      ),
    );
  },
);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold( body: Center(
      child: spinkit
      )
    
      );
  }
}
