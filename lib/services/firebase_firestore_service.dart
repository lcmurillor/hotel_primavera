import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import '../services/services.dart';
import '../models/models.dart';

///Ésta clase corresponde a la conexión a la base datos Firebase y su respectivo
///traslado de datos a los modelos correspondientes.
class FirebaseDatabaseService {
  //Referencia global de la conexión de la base de datos.
  static final FirebaseDatabase _database = FirebaseDatabase.instance;

  ///Éste método selecciona un usuario de la base de datos Firebase por medio del UID
  ///y hace el llamado al método de conversión para retornar un usuario con todos sus
  ///atributos.
  static Future<User> getUserByUid({required String uid}) async {
    late User user;
    final Query query =
        _database.ref().child('users').orderByChild('id').equalTo(uid);
    final DataSnapshot dataSnapshot = await query.get();
    final Map<String, dynamic> data =
        jsonDecode(jsonEncode(dataSnapshot.value));
    data.forEach((key, value) {
      user = User.fromMap(value);
    });
    return user;
  }

  ///Éste método selecciona un usuario de la base de datos Firebase por medio del correo
  ///y hace el llamado al método de conversión para retornar un usuario con todos sus
  ///atributos.
  static Future<User> getUserByEmail(
      {required String email, bool isFromPassword = false}) async {
    late User user = User(email: '', id: '', name: '');
    final Query query =
        _database.ref().child('users').orderByChild('email').equalTo(email);
    final DataSnapshot dataSnapshot = await query.get();
    if (dataSnapshot.value != null) {
      final Map<String, dynamic> data =
          jsonDecode(jsonEncode(dataSnapshot.value));
      data.forEach((key, value) {
        user = User.fromMap(value);
      });
    } else {
      if (!isFromPassword) {
        NotificationsService.showErrorSnackbar(
            'Usuario o contraseña invalida.');
      }
    }
    return user;
  }

  static Future<List<Client>> getClients() async {
    List<Client> clients = [];
    final query = _database.ref().child('clients');
    final DataSnapshot dataSnapshot = await query.get();
    if (jsonDecode(jsonEncode(dataSnapshot.value)) != null) {
      final Map<String, dynamic> data =
          jsonDecode(jsonEncode(dataSnapshot.value));
      data.forEach((key, value) {
        clients.add(Client.fromMap(value));
      });
    }
    return clients;
  }
}
