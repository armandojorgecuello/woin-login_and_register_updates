import 'package:sqflite/sqflite.dart';


final int version=1;
// TABLA SPLASH
final String table1Name = 'splash';
final String columnIds = 'id';
final String columnUsernames = 'username';
final String columnView = 'view';

//TABLA PRESISTENCE SESION
final String tableName = 'user';
final String columnId = 'id';
final String columnUsername = 'username';
final String columnPass = 'password';
final String columnToken = 'token';


class SplashSQLite {
  int id;
  String username;
  int view;



  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnUsernames: username,
      columnView: view,

    };

    return map;
  }

  SplashSQLite({this.username, this.view});

  SplashSQLite.fromMap(Map<String, dynamic> map) {
    id = map[columnIds];
    username = map[columnUsernames];
    view= map[columnView];

  }
}

class SplashProviderDB {
  Database db;

 SplashProviderDB(){

   print("INIT PROVIDER");
 }


  insert(SplashSQLite splash) async {
   try{
     TableSqlite tbl=TableSqlite();
    await tbl.open();

     print(await tbl.db.insert(table1Name, splash.toMap()));
   }on Exception catch(ex){
     print("EXCEPCION=>"+ex.toString());
    }

  }

  Future<SplashSQLite> getUser(int id) async {
    List<Map> maps = await db.query(table1Name,
        columns: [columnIds, columnUsernames, columnView],
        where: '$columnIds = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return SplashSQLite.fromMap(maps.first);
      print("CREADO");
    }
    return null;
  }

  Future<SplashSQLite> getViewSplash() async {
    TableSqlite tbl=TableSqlite();
    await tbl.open();
    List<Map> maps = await tbl.db.query(
      table1Name,
      columns: [columnIds, columnUsernames, columnView,],
    );
    if (maps.length > 0) {
      return SplashSQLite.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    TableSqlite tbl=TableSqlite();
    await tbl.open();
    return await tbl.db.delete(table1Name, where: '$columnIds = ?', whereArgs: [id]);
  }

  Future<int> deleteUserLog() async {
    TableSqlite tbl=TableSqlite();
    await tbl.open();
    return await tbl.db.delete(table1Name);
  }

  Future<int> update(SplashSQLite user) async {
    TableSqlite tbl=TableSqlite();
    await tbl.open();
    return await tbl.db.update(table1Name, user.toMap(),
        where: '$columnIds = ?', whereArgs: [user.id]);
  }

  Future close() async => db.close();
}

class TableSqlite {
  Database db;
  Database get bd=>db;

  Future<int> open() async {

    String path = "DB_WOIN";
    db = await openDatabase(path, version: version,
        onCreate: (Database db, int version) async {
          await db.execute('''create table $table1Name ( 
  $columnIds integer primary key autoincrement, 
  $columnUsernames text not null,
  $columnView integer not null)
''');
          await db.execute('''
create table $tableName (  $columnId integer primary key autoincrement, 
  $columnUsername text not null,
  $columnPass text not null,
  $columnToken text not null)
''');
        });
    print("TABLAS INICIALIZADAS");
  }


}