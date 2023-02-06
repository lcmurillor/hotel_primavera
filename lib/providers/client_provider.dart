import 'package:flutter/material.dart';
import '../services/services.dart';
import '../models/models.dart';

class ClientProvider extends ChangeNotifier {
  List<Client> clients = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumIndex;
  ClientProvider() {
    getPaginatedClients();
  }

  getPaginatedClients() async {
    FirebaseDatabaseService.getClients().then((value) {
      clients = value;
      isLoading = false;
      notifyListeners();
    });
  }

  // Future<Usuario?> getUserByID(String uid) async {
  //   try {
  //     final resp = await CafeApi.httpGet('/usuarios/$uid');
  //     final user = Usuario.fromMap(resp);
  //     return user;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  void sort<T>(Comparable<T> Function(Client) getField) {
    clients.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    ascending = !ascending;
    notifyListeners();
  }

  // void refreshUser(Usuario newUser) {
  //   users = users.map((e) {
  //     if (e.uid == newUser.uid) {
  //       e = newUser;
  //     }
  //     return e;
  //   }).toList();
  //   notifyListeners();
  // }
}
