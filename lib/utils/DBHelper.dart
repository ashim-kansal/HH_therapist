
import 'dart:io';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final String table = 'VideoCallData';
final String id = 'id';
final String userId = 'user_id';
final String roomName = 'room_name';
final String accessToken = 'token';


class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path +"/TestDB.db";
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Client ("
          "id INTEGER PRIMARY KEY,"
          "token TEXT,"
          "identity TEXT,"
          "roomname TEXT,"
          "programname TEXT"
          ")");
    });
  }

  newClient(Client newClient) async {
    final db = await database;
    var res = await db.insert("Client", newClient.toMap());
    return res;
  }

  Future<Client> getAllClients() async {
    final db = await database;
    var res = await db.query("Client");
    List<Client> list =
    res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
    return list.last??Client();
  }

}


Client clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Client.fromMap(jsonData);
}

String clientToJson(Client data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Client {
  int id;
  String token;
  String identity;
  String roomname;
  String programname;

  Client({
    this.id,
    this.token,
    this.identity,
    this.roomname,
    this.programname,
  });

  factory Client.fromMap(Map<String, dynamic> json) => new Client(
    id: json["id"],
    token: json["token"],
    identity: json["identity"],
    roomname: json["roomname"],
    programname: json["programname"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "token": token,
    "identity": identity,
    "roomname": roomname,
    "programname": programname,
  };
}
