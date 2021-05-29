import 'package:sqflite/sqflite.dart';
import 'package:woin/src/services/serviceSplash/ServiceSplash.dart';

final String tableName = 'user';
final String columnId = 'id';
final String columnUsername = 'username';
final String columnPass = 'password';
final String columnToken = 'token';

class UserSQLite {
  int id;
  String username;
  String password;
  String token;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnUsername: username,
      columnPass: password,
      columnToken: token
    };

    return map;
  }

  UserSQLite({this.username, this.password, this.token});

  UserSQLite.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    username = map[columnUsername];
    password = map[columnPass];
    token = map[columnToken];
  }
}

class USerProviderDB {
  Database db;

USerProviderDB(){


}

  insert(UserSQLite user) async {
    TableSqlite tbl=TableSqlite();
    await tbl.open();
    print(await tbl.db.insert(tableName, user.toMap()));
  }

  Future<UserSQLite> getUser(int id) async {
    TableSqlite tbl=TableSqlite();
    await tbl.open();
    List<Map> maps = await tbl.db.query(tableName,
        columns: [columnId, columnUsername, columnPass, columnToken],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return UserSQLite.fromMap(maps.first);
    }
    return null;
  }

  Future<UserSQLite> getUserLogueado() async {
    TableSqlite tbl=TableSqlite();
    await tbl.open();
    List<Map> maps = await tbl.db.query(
      tableName,
      columns: [columnId, columnUsername, columnPass, columnToken],
    );
    if (maps.length > 0) {
      return UserSQLite.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    TableSqlite tbl=TableSqlite();
    await tbl.open();
    return await tbl.db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteUserLog() async {
    TableSqlite tbl=TableSqlite();
    await tbl.open();
    return await tbl.db.delete(tableName);
  }

  Future<int> update(UserSQLite user) async {
    TableSqlite tbl=TableSqlite();
    await tbl.open();
    return await tbl.db.update(tableName, user.toMap(),
        where: '$columnId = ?', whereArgs: [user.id]);
  }

  Future close() async {
    TableSqlite tbl=TableSqlite();
    await tbl.open();
    await db.close();
  }
}
