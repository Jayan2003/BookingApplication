import 'package:final_project_iti/user_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class InsertFlightsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userlogic = BlocProvider.of<Userlogic>(context);

    // Call insertFlight with predefined data
    void insertFlights() {
      userlogic.insertFlight(
        countryFrom: 'USA',
        countryTo: 'GERMANY',
        departureTime: '2024-08-15 10:00:00',
        arrivalTime: '2024-08-15 14:00:00',
        seatNumber: 12,
        price: 12000.00,
        flightClass: 'Economy',
      );
      userlogic.insertFlight(
        countryFrom: 'UK',
        countryTo: 'MEXICO',
        departureTime: '2024-08-20 09:00:00',
        arrivalTime: '2024-08-20 13:00:00',
        seatNumber: 20,
        price: 9000.00,
        flightClass: 'Business',
      );
      userlogic.insertFlight(
        countryFrom: 'CUBA',
        countryTo: 'CANADA',
        departureTime: '2024-08-15 9:00:00',
        arrivalTime: '2024-08-15 5:00:00',
        seatNumber: 80,
        price: 40000.00,
        flightClass: 'Business',
      );
      userlogic.insertFlight(
        countryFrom: 'CHINA',
        countryTo: 'EGYPT',
        departureTime: '2024-08-15 7:00:00',
        arrivalTime: '2024-08-15 3:00:00',
        seatNumber: 15,
        price: 9000.00,
        flightClass: 'First Class',
      );
      userlogic.insertFlight(
        countryFrom: 'FRANCE',
        countryTo: 'CROTIA',
        departureTime: '2024-08-15 10:00:00',
        arrivalTime: '2024-08-15 14:00:00',
        seatNumber: 44,
        price: 17000.00,
        flightClass: 'Economy',
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Insert Flights'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            insertFlights();
            Navigator.pop(context); // Optionally, navigate back after insertion
          },
          child: Text('Insert Flights'),
        ),
      ),
    );
  }
}
