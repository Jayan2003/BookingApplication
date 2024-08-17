import 'package:final_project_iti/user_logic.dart';
import 'package:final_project_iti/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Specials extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userlogic = BlocProvider.of<Userlogic>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Upcoming Flights'),
        backgroundColor: Colors.blue[900],
      ),
      body: BlocBuilder<Userlogic, Userstate>(
        builder: (context, state) {
          if (state is getflight) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildQuerySection(
                    'Flights Under 15000',
                    userlogic.fetchFlightsUnder15000(),
                  ),
                  _buildQuerySection(
                    'Business Class Flights',
                    userlogic.fetchBusinessClassFlights(),
                  ),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildQuerySection(
      String queryName,
      Future<List<Map<dynamic, dynamic>>> flightsFuture,
      ) {
    return FutureBuilder<List<Map<dynamic, dynamic>>>(
      future: flightsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No flights found.'));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                queryName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 200, // Adjust as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final flight = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Container(
                        width: 150, // Adjust as needed
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('From: ${flight['country_from']}'),
                            Text('To: ${flight['country_to']}'),
                            Text('Departure: ${flight['departure_time']}'),
                            Text('Arrival: ${flight['arrival_time']}'),
                            Text('Price: \$${flight['price']}'),
                            Text('Class: ${flight['class']}'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
