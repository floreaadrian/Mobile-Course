import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart';
import 'package:lab1_flutter/passanger.dart';
import 'package:lab1_flutter/repos/local_db_repository.dart';
import 'package:lab1_flutter/repos/repository.dart';

class ServerRepository extends Repository {
  static final String urlBasedOnPlatform =
      Platform.isAndroid ? "10.0.2.2" : "localhost";
  static String baseUrl = "http://" + urlBasedOnPlatform + ":3000/passengers";
  final List<Passanger> toPushWhenOnline = List();
  Map<String, String> headers = {"Content-type": "application/json"};
  final Repository localDb = LocalDbRepository();
  bool canSendToServer = true;

  Future<bool> checkIfInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> addPassangerToServer(Passanger passanger) async {
    Response response = await post(
      baseUrl,
      headers: headers,
      body: json.encode(passanger.toJson()),
    );
    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body);
      Passanger newPassanger = Passanger.fromJson(body);
      localDb.update(passanger, newPassanger);
    } else {
      throw "Couldn't add passanger\n The reason" + response.body + "\n";
    }
  }

  Future<void> addToTheServer() async {
    if (canSendToServer) {
      canSendToServer = false;
      for (Passanger passanger in toPushWhenOnline) {
        await addPassangerToServer(passanger);
      }
      toPushWhenOnline.clear();
      if (toPushWhenOnline.isEmpty) {
        canSendToServer = true;
      }
    }
    return null;
  }

  @override
  Future<Passanger> add(Passanger passanger) async {
    bool internetIsAvalible = await checkIfInternet();
    Passanger newOne = await localDb.add(passanger);
    toPushWhenOnline.add(newOne);
    if (internetIsAvalible == true) {
      await addToTheServer();
    }
    return newOne;
  }

  @override
  Future<void> deletePassanger(Passanger passanger) async {
    String urlToAcces = baseUrl + "/" + passanger.serverId;
    Response response = await delete(urlToAcces);
    if (response.statusCode == 200) {
      localDb.deletePassanger(passanger);
      print("delete completed");
    } else {
      throw "Couldn't delete";
    }
  }

  @override
  Future<List<Passanger>> getAll() async {
    bool internetIsAvalible = await checkIfInternet();
    if (internetIsAvalible) {
      await addToTheServer();
      Response res = await get(baseUrl);
      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);
        List<Passanger> posts = body
            .map(
              (dynamic item) => Passanger.fromJson(item),
            )
            .toList();
        return posts;
      } else {
        throw "Can't get passanger.";
      }
    } else {
      return localDb.getAll();
    }
  }

  @override
  Future<void> update(Passanger oldPassanger, Passanger passanger) async {
    String urlToAcces = baseUrl + "/" + oldPassanger.serverId;
    Response response = await put(
      urlToAcces,
      headers: headers,
      body: json.encode(passanger.toJson()),
    );
    if (response.statusCode == 200) {
      localDb.update(oldPassanger, passanger);
    } else {
      throw "Couldn't update";
    }
    return null;
  }
}
