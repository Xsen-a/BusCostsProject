import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void deleteBus(busId) async {
  String path = join(await getDatabasesPath(), 'busDatabase.db');
  Database database = await openDatabase(path);

  await database.delete(
    'tblBus',
    where: 'bus_id = ?',
    whereArgs: [busId],
  );

}

