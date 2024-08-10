import 'package:flutter/material.dart';
import 'package:newtoktech_task/screen/admin/addloc.dart';

class AdminDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: const Color.fromARGB(255, 105, 240, 175),
      ),
      body: Center(
        child: Container(
          color: Color.fromARGB(149, 172, 255, 215),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return AddLocationScreen();
                  },
                )),
                child: const Text('Add Location'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}