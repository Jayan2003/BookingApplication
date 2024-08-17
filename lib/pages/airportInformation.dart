import 'package:flutter/material.dart';

class AirportInformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airport Information', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white)),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildInformationTile('Cafeteria', 'Located on the Ground Floor near Gate 12. Open 24/7.'),
            SizedBox(height: 10),
            _buildInformationTile('WC', 'Available on every floor. Closest to Gate 14 and Gate 5.'),
            SizedBox(height: 10),
            _buildInformationTile('Terminal 1', 'First Floor, Gates 1-10. Check-in counters A to E.'),
            SizedBox(height: 10),
            _buildInformationTile('Terminal 2', 'Second Floor, Gates 11-20. Check-in counters F to J.'),
            SizedBox(height: 10),
            _buildInformationTile('Security Check', 'Located after the check-in counters on the First Floor.'),
            SizedBox(height: 10),
            _buildInformationTile('Lounge', 'Second Floor, near Gate 15. Access for Business and First Class passengers.'),
            SizedBox(height: 10),
            _buildInformationTile('Baggage Claim', 'Ground Floor, near the exit gates. Available 24/7.'),
            SizedBox(height: 10),
            _buildInformationTile('Parking', 'Multi-level parking available. Entrance from the main road, follow signs.'),
            SizedBox(height: 10),
            _buildInformationTile('Information Desk', 'Located in the main concourse, near the entrance. Open 24/7.'),
          ],
        ),
      ),
    );
  }

  Widget _buildInformationTile(String place, String description) {
    return Card(
      color: Colors.blue[50],
      child: ListTile(
        title: Text(
          place,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description, style: TextStyle(fontSize: 16)),
        leading: Icon(Icons.place, color: Colors.blue[900], size: 40),
      ),
    );
  }
}
