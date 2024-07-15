import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:bus_costs/screens/add_trip.dart';

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

Future<List<Bus>> getFormattedBusNumbers(String query) async {
  String path = join(await getDatabasesPath(), 'busDatabase.db');
  Database database = await openDatabase(path);

  List<Map<String, dynamic>> busNumbers = await database.query(
      'tblBus',
      columns: ['bus_num', 'bus_type']);

  List<Bus> formattedBusNumbers = [];
  for (int i = 0; i < busNumbers.length; i ++)
  {
    if (busNumbers[i]['bus_type'] == 1) {
      formattedBusNumbers.add(Bus(busNumbers[i]['bus_num'].toString() + " А"));
    } else {
      formattedBusNumbers.add(Bus(busNumbers[i]['bus_num'].toString() + " Т")); }
  }

  //return formattedBusNumbers;
    return formattedBusNumbers.where((e) {
        return e.number.toLowerCase().contains(query.toLowerCase());
      }).toList();
}
//
// Future<List<Bus>> getFormattedBusNumbers(String query) async {
//   String path = join(await getDatabasesPath(), 'busDatabase.db');
//   Database database = await openDatabase(path);
//
//   List<Map<String, dynamic>> busNumbers = await database.query(
//       'tblBus',
//       columns: ['bus_num', 'bus_type']);
//
//   List<Bus> formattedBusNumbers = [];
//   for (int i = 0; i < busNumbers.length; i ++)
//   {
//     if (busNumbers[i]['bus_type'] == 1) {
//       formattedBusNumbers.add(Bus(busNumbers[i]['bus_num'].toString() + " А"));
//     } else {
//       formattedBusNumbers.add(Bus(busNumbers[i]['bus_num'].toString() + " Т")); }
//   }
//
//   return formattedBusNumbers;
// }
