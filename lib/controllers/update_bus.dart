import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void updateBus(busType, busNumber, busCost, busColor, busId) async {
  String path = join(await getDatabasesPath(), 'busDatabase.db');
  Database database = await openDatabase(path);

  if (busType == "А" || busType == "1")
    busType = "1";
  else
    busType = "2";

  String formattedBusColor;

  if (busColor.length != 7)
    formattedBusColor = busColor.replaceAll("0xFF", "#");
  else
    formattedBusColor = busColor;
  print(busId);

  int rows = await database.update(
    'tblBus',
    {
      'bus_type': busType,
      'bus_num': busNumber,
      'bus_cost': busCost,
      'bus_color': formattedBusColor
    },
    where: 'bus_id = ?',
    whereArgs: [busId],
  );

  if (rows > 0) {
    print('Данные успешно обновлены');
  } else {
    print('Ошибка при обновлении данных');
  }
}


Future<bool> checkBusExistenceUpdate(String busNumber, String busType, busId) async {
  String path = join(await getDatabasesPath(), 'busDatabase.db');
  Database database = await openDatabase(path);

  if (busType == "А") {
    busType = "1";
  } else {
    busType = "2"; }

  List<Map<String, dynamic>> buses = await database.query(
      'tblBus',
      columns: ["bus_id"],
      where: 'bus_num = "$busNumber" AND bus_type = "$busType"');

  if (buses.length == 1) {
    return true;
  } else {
    return false;
  }
}

