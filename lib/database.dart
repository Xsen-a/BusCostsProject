import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<void> createDatabase() async {
  // Откройте соединение с базой данных:
  Database database = await openDatabase(join(await getDatabasesPath(), 'busDatabase.db'), version: 1,
      onCreate: (Database db, int version) async {
      // создание
      await db.execute('''
            CREATE TABLE IF NOT EXISTS tblBus(
              bus_id INTEGER PRIMARY KEY,
              bus_type INTEGER NOT NULL,
              bus_num VARCHAR(255) NOT NULL,
              bus_cost VARCHAR(255) NOT NULL,
              bus_color VARCHAR(255) NOT NULL
            );
          ''');
      await db.execute('''
            CREATE TABLE IF NOT EXISTS tblTrip(
              trip_id INTEGER PRIMARY KEY,
              trip_date DATE NOT NULL,
              trip_time VARCHAR(255) NOT NULL,
              ticket_status BOOLEAN NOT NULL,
              bus_id INTEGER NOT NULL,
              bus_cost VARCHAR(255) NOT NULL,
              FOREIGN KEY (bus_id) REFERENCES tblBus(bus_id)
              FOREIGN KEY (bus_cost) REFERENCES tblBus(bus_cost)
            );
          ''');
      // Заполнение
      // await db.execute('''
      //       INSERT INTO tblBus(bus_type, bus_num, bus_cost, bus_color) VALUES
      //       (1, '17', '50', '#FF604A');
      //     ''');
      // await db.execute('''
      //       INSERT INTO tblBus(bus_type, bus_num, bus_cost, bus_color) VALUES
      //       (2, '6', '38', '#9EFFB9');
      //     ''');
      await db.execute('''
            INSERT INTO tblTrip(trip_date, trip_time, ticket_status, bus_id, bus_cost) VALUES
            ('2024-06-02', '17:00', false, 1, '50');
          ''');
      });
}