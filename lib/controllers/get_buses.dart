import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<List<Map<String, dynamic>>> getBusesList() async {
  String path = join(await getDatabasesPath(), 'busDatabase.db');
  Database database = await openDatabase(path);

  List<Map<String, dynamic>> busesData = await database.query(
    'tblBus',
  );

  return busesData;
}

