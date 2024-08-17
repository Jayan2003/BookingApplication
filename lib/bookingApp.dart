import 'package:final_project_iti/homepage.dart';
import 'package:final_project_iti/pages/airportInformation.dart';
import 'package:final_project_iti/pages/specials.dart';
import 'package:flutter/material.dart';



class BookingApp extends StatefulWidget {
  @override
  _BookingAppState createState() => _BookingAppState();
}

class _BookingAppState extends State<BookingApp> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Length remains 3
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Booking App',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Colors.blue[900],
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(
                text: 'Search Flights',
                icon: Icon(Icons.search),
              ),
              Tab(
                text: 'Special Offers',
                icon: Icon(Icons.local_fire_department_sharp),
              ),
              Tab(
                text: 'Airport Information',
                icon: Icon(Icons.info_outline),
              ),
            ],
          ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.payment),
                title: Text("Payment"),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text("About us"),
                onTap: () {
                  /*
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUsScreen()),
                  );
               */
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Log Out"),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [Homepage(), Specials(), AirportInformationPage()],
        ),
      ),
    );
  }
}
