import 'package:final_project_iti/Insertionpage.dart';
import 'package:final_project_iti/user_logic.dart';
import 'package:final_project_iti/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class Insertion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userlogic = BlocProvider.of<Userlogic>(context);

    // Trigger fetch flights data automatically
    userlogic.fetchFlights().then((_) {
      userlogic.emit(getflight());
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Flights'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InsertFlightsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<Userlogic, Userstate>(
        builder: (context, state) {
          if (state is getflight) {
            // Ensure flights data is loaded
            if (userlogic.flights.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: userlogic.flights.length,
              itemBuilder: (context, index) {
                final flight = userlogic.flights[index];
                return Card(
                  child: ListTile(
                    title: Text(
                        'Flight from ${flight['country_from']} to ${flight['country_to']}'),
                    subtitle: Text('Price: \$${flight['price']}'),
                    trailing: Text('Class: ${flight['class']}'),
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
