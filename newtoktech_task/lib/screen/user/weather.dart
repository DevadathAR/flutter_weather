import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newtoktech_task/const.dart';
import 'package:weather/weather.dart';

class WeatherPage extends StatefulWidget {
  final String cityName;

  const WeatherPage({Key? key, required this.cityName}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      Weather weather = await _wf.currentWeatherByCityName(widget.cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print('Failed to fetch weather: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather in ${widget.cityName}'),
        backgroundColor: Colors.blueAccent,
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    if (_weather == null) {
      return Container(color: const Color.fromARGB(255, 255, 255, 197),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Container(color: const Color.fromARGB(255, 255, 255, 197),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_locationHeader(), _dateTimeInfo(), _weatherIcon(),_currentTemp()],
        ),
      ),
    );
  }

  Widget _locationHeader() {
    return Text(_weather?.areaName ?? "",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600),);
  }

  Widget _dateTimeInfo() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(DateFormat("h:mm a").format(now),style: TextStyle(fontSize: 22),),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(DateFormat("EEEE").format(now)),
            Text("${DateFormat("d.m.y").format(now)}"),
          ],
        ),
      ],
    );
  }

  Widget _weatherIcon() {
    return Column(
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * .25,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"))),
        ),
        Text(_weather?.weatherDescription ?? "")
      ],
    );
  }
  Widget _currentTemp(){
  return Text("${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",style: TextStyle(fontSize: 42,fontWeight: FontWeight.bold),);
}
}


class WeatherReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reports = [
      'Weather Report 1',
      'Weather Report 2',
      'Weather Report 3',
      'Weather Report 4',
      'Weather Report 5',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Weather Reports')),
      body: ListView.builder(
        itemCount: reports.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(reports[index]),
          );
        },
      ),
    );
  }
}
