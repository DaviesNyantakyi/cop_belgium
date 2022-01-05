import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionChecker extends ChangeNotifier {
  bool hasConnection = false;

  Future<void> intializeConnectionChecker() async {
    InternetConnectionChecker()
        .onStatusChange
        .listen((InternetConnectionStatus status) async {
      await checkConnection();
    });
    await checkConnection();
  }

  Future<bool> checkConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    hasConnection = result;
    notifyListeners();
    return result;
  }

  static FirebaseException connectionException = FirebaseException(
    plugin: 'Connection Checker:',
    code: 'No connection',
    message:
        'No internet connection. Make sure your wifi or cellular data is turned on',
  );
}
