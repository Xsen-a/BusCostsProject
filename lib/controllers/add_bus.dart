import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void addNewBus(busType, busNumber, busCost, busColor) async {
  String path = join(await getDatabasesPath(), 'busDatabase.db');
  Database database = await openDatabase(path);

  if (busType == "А")
    busType = "1";
  else
    busType = "2";

  String formattedBusColor;

  if (busColor.length != 7)
    formattedBusColor = busColor.replaceAll("0xFF", "#");
  else
    formattedBusColor = busColor;

  await database.insert(
    'tblBus',
    {
      'bus_type': busType,
      'bus_num': busNumber,
      'bus_cost': busCost,
      'bus_color': formattedBusColor
    },
    conflictAlgorithm: ConflictAlgorithm.ignore,
  );
}

Future<bool> checkBusExistence(String busNumber, String busType) async {
  String path = join(await getDatabasesPath(), 'busDatabase.db');
  Database database = await openDatabase(path);

  if (busType == "А") {
    busType = "1";
  } else {
    busType = "2"; }

  List<Map<String, dynamic>> buses = await database.query(
      'tblBus',
      where: 'bus_num = "$busNumber" AND bus_type = "$busType"',
      limit: 1);

    if (buses.isEmpty) {
      return false;
    } else {
      return true;
    }
}

