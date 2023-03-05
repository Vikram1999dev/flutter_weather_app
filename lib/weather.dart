// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Weather extends StatefulWidget {
  Weather({super.key});
  static const routeName = '/weather';

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windspeed;
  var name;

  Future getWeather(String? myCity) async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$myCity&appid=da40ebcad5c70f96d957021fcefdc718'));
      var results = jsonDecode(response.body);
      setState(() {
        temp = results['main']['temp'].toInt() / 10;
        description = results['weather'][0]['description'];
        currently = results['weather'][0]['main'];
        humidity = results['main']['humidity'];
        windspeed = results['wind']['speed'];
        name = results['name'];
      });
    } catch (e) {
      print(e);
    }
  }

// The ModalRoute.of(context) method should not be called in the initState method
// because the context is not yet fully initialized at this point. The ModalRoute
// requires access to the BuildContext in order to retrieve the route arguments,
// but BuildContext is only available after the widget has been fully initialized.

// To fix the error, you can move the getWeather method call to the didChangeDependencies
// method, which is called after the context has been fully initialized.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var myCity = ModalRoute.of(context)!.settings.arguments as String?;
    getWeather(myCity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        backgroundColor: Colors.blue,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'Currently in ${name ?? 'Loading'}',
                    // name != null ? 'Currently in $name' : 'Loading',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  temp != null ? '$temp \u00B0' : 'Loading',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    currently != null ? '$currently' : 'Loading',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.temperatureHalf),
                    title: Text('Temperature'),
                    trailing: Text(temp != null ? '$temp \u00B0' : 'Loading'),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text('Weather'),
                    trailing:
                        Text(description != null ? '$description' : 'Loading'),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text('Humidity'),
                    trailing: Text(humidity != null ? '$humidity' : 'Loading'),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text('Wind Speed'),
                    trailing:
                        Text(windspeed != null ? '$windspeed' : 'Loading'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
