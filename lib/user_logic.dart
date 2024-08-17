import 'package:final_project_iti/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class Userlogic extends Cubit<Userstate> {
  Userlogic() : super(inituser());
  List<Map> users = [];
  List<Map> flights = [];

  List<Map> flightsUnder15000 = [];
  List<Map> businessClassFlights = [];
  late Database db;
  String selectedFromCountry = '';
  String selectedToCountry = '';
  DateTime selectedDepartureDate = DateTime.now();
  DateTime selectedArrivalDate = DateTime.now().add(Duration(days: 7));

  Future<void> createDatabaseAndTable() async {
    db = await openDatabase(
      'example.db',
      version: 3,
      onCreate: (Database db, int version) async {
        print("Database created!");
        await db.execute(
          'CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, email TEXT UNIQUE NOT NULL, password TEXT NOT NULL)',
        );
        print('Table users created!');
        await db.execute(
          'CREATE TABLE flights (ticket_id INTEGER PRIMARY KEY AUTOINCREMENT, country_from TEXT NOT NULL, country_to TEXT NOT NULL, departure_time TEXT NOT NULL, arrival_time TEXT NOT NULL, seat_number INTEGER NOT NULL, price DOUBLE NOT NULL, class TEXT NOT NULL)',
        );
        print('Table flights created!');
        await db.execute(
          'CREATE TABLE user_flights (user_id INTEGER, ticket_id INTEGER, PRIMARY KEY(user_id, ticket_id), FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE, FOREIGN KEY(ticket_id) REFERENCES flights(ticket_id) ON DELETE CASCADE)',
        );
        print('Table user_flights created!');
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if (oldVersion < 3) {
          await db.execute(
            'CREATE TABLE user_flights (user_id INTEGER, ticket_id INTEGER, PRIMARY KEY(user_id, ticket_id), FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE, FOREIGN KEY(ticket_id) REFERENCES flights(ticket_id) ON DELETE CASCADE)',
          );
          print('Table user_flights created on upgrade!');
        }
      },
    );

    fetchUsers().then((value) {
      users = value;
      print('Fetched users: $value');
      emit(getuser());
    });

    fetchFlights().then((value) {
      flights = value;
      print('Fetched flights: $value');
      emit(getflight());
    });

    fetchFlightsUnder15000().then((value) {
      flightsUnder15000 = value;
      print('Fetched flights under 15,000: $value');
      emit(flightsUnder15000State());
    });

    fetchBusinessClassFlights().then((value) {
      businessClassFlights = value;
      print('Fetched business class flights: $value');
      emit(businessClassFlightsState());
    });

    emit(createuser());
  }

  Future<void> insertUser({
    required String name,
    required String email,
    required String password,
  }) async {
    await db.transaction((txn) async {
      try {
        final int id = await txn.rawInsert(
          'INSERT INTO users (name, email, password) VALUES (?, ?, ?)',
          [name, email, password],
        );
        print('Inserted user with row id $id');
        emit(insertuser());
        fetchUsers().then((value) {
          users = value;
          print('Fetched users after insert: $value');
          emit(getuser());
        });
      } catch (e) {
        print('Error inserting user: $e');
      }
    });
  }

  Future<void> insertFlight({
    required String countryFrom,
    required String countryTo,
    required String departureTime,
    required String arrivalTime,
    required int seatNumber,
    required double price,
    required String flightClass,
  }) async {
    await db.transaction((txn) async {
      try {
        final int ticketId = await txn.rawInsert(
          'INSERT INTO flights (country_from, country_to, departure_time, arrival_time, seat_number, price, class) VALUES (?, ?, ?, ?, ?, ?, ?)',
          [
            countryFrom,
            countryTo,
            departureTime,
            arrivalTime,
            seatNumber,
            price,
            flightClass
          ],
        );
        print('Inserted flight with row id $ticketId');
        emit(insertflight());
        fetchFlights().then((value) {
          flights = value;
          print('Fetched flights after insert: $value');
          emit(getflight());
        });
      } catch (e) {
        print('Error inserting flight: $e');
      }
    });
  }

  Future<void> updateFlight({
    required int ticketId,
    required String countryFrom,
    required String countryTo,
    required String departureTime,
    required String arrivalTime,
    required int seatNumber,
    required double price,
    required String flightClass,
  }) async {
    await db.transaction((txn) async {
      try {
        await txn.rawUpdate(
          'UPDATE flights SET country_from = ?, country_to = ?, departure_time = ?, arrival_time = ?, seat_number = ?, price = ?, class = ? WHERE ticket_id = ?',
          [
            countryFrom,
            countryTo,
            departureTime,
            arrivalTime,
            seatNumber,
            price,
            flightClass,
            ticketId
          ],
        );
        print('Updated flight with id $ticketId');
        emit(updateflight());
        fetchFlights().then((value) {
          flights = value;
          print('Fetched flights after update: $value');
          emit(getflight());
        });
      } catch (e) {
        print('Error updating flight: $e');
      }
    });
  }

  Future<List<Map>> fetchFlights() async {
    return await db.rawQuery('SELECT * FROM flights');
  }

  Future<List<Map>> fetchUsers() async {
    return await db.rawQuery('SELECT * FROM users');
  }

  Future<List<Map>> fetchFlightsUnder15000() async {
    return await db.rawQuery('SELECT * FROM flights WHERE price < ?', [15000]);
  }

  Future<List<Map>> fetchBusinessClassFlights() async {
    return await db
        .rawQuery('SELECT * FROM flights WHERE class = ?', ['Business']);
  }
}
