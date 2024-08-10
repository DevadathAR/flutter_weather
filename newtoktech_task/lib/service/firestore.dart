import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addLocation(Map<String, String> location) async {
    try {
      await _firestore.collection('locations').add(location);
      print('Location added successfully: $location');
    } catch (e) {
      print('Failed to add location: $e');
    }
  }

  Future<List<String>> getCountries() async {
    try {
      final snapshot = await _firestore.collection('locations').get();
      Set<String> countries = {};
      for (var doc in snapshot.docs) {
        final data = doc.data();
        if (data.containsKey('country')) {
          countries.add(data['country']);
        }
      }
      return countries.toList();
    } catch (e) {
      print('Failed to fetch countries: $e');
      return [];
    }
  }

  Future<List<String>> getStatesByCountry(String country) async {
    try {
      final snapshot = await _firestore
          .collection('locations')
          .where('country', isEqualTo: country)
          .get();
      Set<String> states = {};
      for (var doc in snapshot.docs) {
        final data = doc.data();
        if (data.containsKey('state')) {
          states.add(data['state']);
        }
      }
      return states.toList();
    } catch (e) {
      print('Failed to fetch states: $e');
      return [];
    }
  }

  Future<List<String>> getDistrictsByState(String state) async {
    try {
      final snapshot = await _firestore
          .collection('locations')
          .where('state', isEqualTo: state)
          .get();
      Set<String> districts = {};
      for (var doc in snapshot.docs) {
        final data = doc.data();
        if (data.containsKey('district')) {
          districts.add(data['district']);
        }
      }
      return districts.toList();
    } catch (e) {
      print('Failed to fetch districts: $e');
      return [];
    }
  }

  Future<List<String>> getCitiesByDistrict(String district) async {
    try {
      final snapshot = await _firestore
          .collection('locations')
          .where('district', isEqualTo: district)
          .get();
      Set<String> cities = {};
      for (var doc in snapshot.docs) {
        final data = doc.data();
        if (data.containsKey('city')) {
          cities.add(data['city']);
        }
      }
      return cities.toList();
    } catch (e) {
      print('Failed to fetch cities: $e');
      return [];
    }
  }
}

