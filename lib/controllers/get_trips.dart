import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<List<Map<String, dynamic>>> getTripsList() async {
  String path = join(await getDatabasesPath(), 'busDatabase.db');
  Database database = await openDatabase(path);

  List<Map<String, dynamic>> tripsData = await database.query(
    'tblTrip',
  );

  return tripsData;
}

Future<Map<String, dynamic>> getBusNumber(int bus_id) async {
  String path = join(await getDatabasesPath(), 'busDatabase.db');
  Database database = await openDatabase(path);

  List<Map<String, dynamic>> busNumber = await database.query(
      'tblBus',
      columns: ['bus_num'],
      where: 'bus_id = "$bus_id"',
      limit: 1);

  return busNumber.first;
}

Future<Map<String, dynamic>> getBusColor(int bus_id) async {
  String path = join(await getDatabasesPath(), 'busDatabase.db');
  Database database = await openDatabase(path);

  List<Map<String, dynamic>> busColor = await database.query(
      'tblBus',
      columns: ['bus_color'],
      where: 'bus_id = "$bus_id"',
      limit: 1);
  return busColor.first;
}
