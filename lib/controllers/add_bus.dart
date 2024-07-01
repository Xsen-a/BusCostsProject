import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void addNewBus(busType, busNumber, busCost, busColor) async {
  String path = join(await getDatabasesPath(), 'busDatabase.db');
  Database database = await openDatabase(path);

  if (busType == "А")
    busType = "1";
  else
    busType = "2";

  await database.insert(
      // INSERT INTO tblBus(bus_type, bus_num, bus_cost, bus_color) VALUES
    'tblBus',
    {
      'bus_type': busType,
      'bus_num': busNumber,
      'bus_cost': busCost,
      'bus_color': busColor
    },
    conflictAlgorithm: ConflictAlgorithm.ignore,
  );
}

