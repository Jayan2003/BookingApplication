import 'dart:async';

import 'package:final_project_iti/pages/listOfFlights.dart';
import 'package:final_project_iti/user_logic.dart';
import 'package:final_project_iti/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class PeriodicUpdater {
  static Timer? _timer;

  static void startUpdating(Userlogic userlogic) {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 7), (timer) {
      userlogic.fetchFlights().then((value) {
        userlogic.flights = value;
        userlogic.emit(getflight()); // Ensure this is the correct method
      });
    });
  }

  static void stopUpdating() {
    _timer?.cancel();
  }
}

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userlogic = BlocProvider.of<Userlogic>(context);

    // Start periodic updates
    PeriodicUpdater.startUpdating(userlogic);

    return Scaffold(
      body: BlocBuilder<Userlogic, Userstate>(
        builder: (context, state) {
          if (state is getflight) {
            // Extract countries and classes from flights data
            final countries = <String>{};
            final flightClasses = <String>{};

            for (var flight in userlogic.flights) {
              countries.add(flight['country_from']);
              countries.add(flight['country_to']);
              flightClasses.add(flight['class']);
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    width: double.infinity,
                    color: Colors.blue[900],
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildLocationDropdown(
                                context, 'FROM', userlogic.selectedFromCountry,
                                    (newValue) {
                                  userlogic.selectedFromCountry = newValue!;
                                }, countries.toList()),
                            Icon(Icons.compare_arrows,
                                color: Colors.white, size: 60),
                            _buildLocationDropdown(
                                context, 'TO', userlogic.selectedToCountry,
                                    (newValue) {
                                  userlogic.selectedToCountry = newValue!;
                                }, countries.toList()),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        _buildDatePicker(context, 'DEPARTURE',
                            userlogic.selectedDepartureDate, (pickedDate) {
                              if (pickedDate != null) {
                                userlogic.selectedDepartureDate = pickedDate;
                              }
                            }),
                        SizedBox(height: 20),
                        _buildDatePicker(
                            context, 'ARRIVAL', userlogic.selectedArrivalDate,
                                (pickedDate) {
                              if (pickedDate != null) {
                                userlogic.selectedArrivalDate = pickedDate;
                              }
                            }),
                        SizedBox(height: 20),
                        _buildDropdownMenu(context, flightClasses.toList()),
                        SizedBox(height: 20),
                        MaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FlightsListScreen()),
                            );
                          },
                          color: Colors.blue[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(
                                color: Colors.blue[900]!, width: 2.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 24.0),
                          child: Text(
                            "Search Flights",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
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

  Widget _buildLocationDropdown(
      BuildContext context,
      String label,
      String? selectedValue,
      ValueChanged<String?> onChanged,
      List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        DropdownButton<String>(
          value: options.contains(selectedValue)
              ? selectedValue
              : null, // Ensure the value is in the options list
          dropdownColor: Colors.blue[900],
          iconEnabledColor: Colors.white,
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          onChanged: onChanged,
          items: options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDatePicker(BuildContext context, String label,
      DateTime selectedDate, Function(DateTime?) onDateSelected) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime.now(),
              lastDate: DateTime(2101),
            );
            onDateSelected(pickedDate);
          },
          child: Text(
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownMenu(BuildContext context, List<String> options) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'CLASS',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        DropdownButton<String>(
          value: options.isNotEmpty
              ? options.first
              : null, // Ensure a default value is set if options are not empty
          onChanged: (String? newValue) {
            // Handle class change
          },
          items: options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
