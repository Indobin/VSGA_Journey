import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';
import 'package:vsga_app/models/akun.dart';

class AkunHelper {
  Future<int> registerAkun(Akun akun) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert('akun', akun.toMap());
  }

  Future<Akun?> loginAkun(String username, String password) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query(
      'akun', where: 'username = ? AND password = ?',
       whereArgs: [username, password]);
    return result.isNotEmpty ? Akun.fromMap(result.first) : null;
  }
}