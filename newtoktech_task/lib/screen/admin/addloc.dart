import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddLocationScreen extends StatefulWidget {
  @override
  _AddLocationScreenState createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  final _countryController = TextEditingController();
  final _stateController = TextEditingController();
  final _districtController = TextEditingController();
  final _cityController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _addLocation() async {
    try {
      await _firestore.collection('locations').add({
        'country': _countryController.text,
        'state': _stateController.text,
        'district': _districtController.text,
        'city': _cityController.text,
      });

      _countryController.clear();
      _stateController.clear();
      _districtController.clear();
      _cityController.clear();

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Location Added')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to add location: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Location'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        color: const Color.fromARGB(137, 188, 255, 223),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                  controller: _countryController,
                  decoration: const InputDecoration(
                      labelText: 'Country',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20))))),
              SizedBox(
                height: 5,
              ),
              TextField(
                  controller: _stateController,
                  decoration: const InputDecoration(
                      labelText: 'State',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20))))),
              SizedBox(
                height: 5,
              ),
              TextField(
                  controller: _districtController,
                  decoration: const InputDecoration(
                      labelText: 'District',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20))))),
              SizedBox(
                height: 5,
              ),
              TextField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                      labelText: 'City',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20))))),
              SizedBox(
                height: 5,
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _addLocation, child: const Text('Add')),
            ],
          ),
        ),
      ),
    );
  }
}
