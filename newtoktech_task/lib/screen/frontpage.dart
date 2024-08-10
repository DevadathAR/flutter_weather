import 'package:flutter/material.dart';
import 'package:newtoktech_task/screen/admin/admindash.dart';
import 'package:newtoktech_task/screen/user/userdash.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: 
 BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person,color: Colors.black,), 

            label: 'User',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.how_to_reg_sharp,color: Colors.black,),
            label: 'Admin',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserDashboardScreen()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminDashboardScreen()),
            );
          }
        },
      ),
      body: Container(color: const Color.fromARGB(255, 255, 255, 197),
        child: const Center(
          child: Text("Weather Now",style: TextStyle(fontSize: 28),),
        ),
      ),
    );
  }
}