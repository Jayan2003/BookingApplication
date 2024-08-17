import 'package:final_project_iti/pages/paymentpage.dart';
import 'package:final_project_iti/user_logic.dart';
import 'package:final_project_iti/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FlightsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userlogic = BlocProvider.of<Userlogic>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Available Flights'),
        backgroundColor: Colors.blue[900],
      ),
      body: BlocBuilder<Userlogic, Userstate>(
        builder: (context, state) {
          if (state is getflight) {
            final flights = userlogic.flights;

            return ListView.builder(
              itemCount: flights.length,
              itemBuilder: (context, index) {
                final flight = flights[index];
                return ListTile(
                  title: Text(
                      '${flight['country_from']} to ${flight['country_to']}'),
                  subtitle: Text(
                      'Class: ${flight['class']} - Price: ${flight['price']}'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(flight: flight),
                        ),
                      );
                    },
                    child: Text('Buy'),
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
