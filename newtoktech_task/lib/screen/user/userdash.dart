import 'package:flutter/material.dart';
import 'package:newtoktech_task/service/firestore.dart';
import 'package:newtoktech_task/screen/user/uploadexcl.dart';
import 'package:newtoktech_task/screen/user/weather.dart';

class UserDashboardScreen extends StatefulWidget {
  @override
  _UserDashboardScreenState createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  String? selectedCountry;
  String? selectedState;
  String? selectedDistrict;
  String? selectedCity;
  Future<List<String>>? _countriesFuture;
  Future<List<String>>? _statesFuture;
  Future<List<String>>? _districtsFuture;
  Future<List<String>>? _citiesFuture;

  @override
  void initState() {
    super.initState();
    _countriesFuture = _firestoreService.getCountries();
  }

  void _onCountrySelected(String? country) {
    setState(() {
      selectedCountry = country;
      selectedState = null;
      selectedDistrict = null;
      selectedCity = null;
      _statesFuture = country != null ? _firestoreService.getStatesByCountry(country) : null;
      _districtsFuture = null;
      _citiesFuture = null;
    });
  }

  void _onStateSelected(String? state) {
    setState(() {
      selectedState = state;
      selectedDistrict = null;
      selectedCity = null;
      _districtsFuture = state != null ? _firestoreService.getDistrictsByState(state) : null;
      _citiesFuture = null;
    });
  }

  void _onDistrictSelected(String? district) {
    setState(() {
      selectedDistrict = district;
      selectedCity = null;
      _citiesFuture = district != null ? _firestoreService.getCitiesByDistrict(district) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Dashboard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(width: double.infinity,
        color: const Color.fromARGB(255, 165, 198, 255),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              FutureBuilder<List<String>>(
                future: _countriesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No countries found.'));
                  } else {
                    final countries = snapshot.data!;
                    return DropdownButton<String?>(
                      value: selectedCountry,
                      hint: Text('Country'),
                      items: countries.map((country) {
                        return DropdownMenuItem<String?>(
                          value: country,
                          child: Text(country),
                        );
                      }).toList(),
                      onChanged: _onCountrySelected,
                    );
                  }
                },
              ),

              if (selectedCountry != null) ...[
                FutureBuilder<List<String>>(
                  future: _statesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No states found.'));
                    } else {
                      final states = snapshot.data!;
                      return DropdownButton<String?>(
                        value: selectedState,
                        hint: Text('State'),
                        items: states.map((state) {
                          return DropdownMenuItem<String?>(
                            value: state,
                            child: Text(state),
                          );
                        }).toList(),
                        onChanged: _onStateSelected,
                      );
                    }
                  },
                ),
              ],

              if (selectedState != null) ...[
                FutureBuilder<List<String>>(
                  future: _districtsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No districts found.'));
                    } else {
                      final districts = snapshot.data!;
                      return DropdownButton<String?>(
                        value: selectedDistrict,
                        hint: Text('District'),
                        items: districts.map((district) {
                          return DropdownMenuItem<String?>(
                            value: district,
                            child: Text(district),
                          );
                        }).toList(),
                        onChanged: _onDistrictSelected,
                      );
                    }
                  },
                ),
              ],

              if (selectedDistrict != null) ...[
                FutureBuilder<List<String>>(
                  future: _citiesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No cities found.'));
                    } else {
                      final cities = snapshot.data!;
                      return DropdownButton<String?>(
                        value: selectedCity,
                        hint: Text('City'),
                        items: cities.map((city) {
                          return DropdownMenuItem<String?>(
                            value: city,
                            child: Text(city),
                          );
                        }).toList(),
                        onChanged: (city) {
                          if (city != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return WeatherPage(cityName: city);
                                },
                              ),
                            );
                          }
                        },
                      );
                    }
                  },
                ),
              ],

              SizedBox(height: 250,),

              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UploadExcelScreen(),
                  ),
                ),
                child: const Text('Upload Excel File'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
