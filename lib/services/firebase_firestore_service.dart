import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/models.dart';

///Ésta clase corresponde a la conexión a la base datos Firebase y su respectivo
///traslado de datos a los modelos correspondientes.
class FirebaseFirestoreService {
  //Referencia global de la conexión de la base de datos.
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///Éste método selecciona un usuario de la base de datos Firebase por medio del UID
  ///y hace el llamado al método de conversión para retornar un usuario con todos sus
  ///atributos.
  static Stream<List<User>> getUserByUid(String uid) {
    final ref = _db.collection('users').where('id', isEqualTo: uid);
    return ref.snapshots().map(
        (list) => list.docs.map((doc) => User.fromMap(doc.data())).toList());
  }

  ///Éste método selecciona un usuario de la base de datos Firebase por medio del correo
  ///y hace el llamado al método de conversión para retornar un usuario con todos sus
  ///atributos.
  static Future<User?> getUserByEmail({required String email}) {
    return _db.collection('users').where('email', isEqualTo: email).get().then(
        (snapshot) =>
            0 == snapshot.size ? null : User.fromMap(snapshot.docs[0].data()));
  }

  ///Éste método permite crear un nuevo usuario en la base de datos. Es solo requerido cuando
  ///un usuario es registrado por primera vez.
  static void setUser({required User user}) {
    _db.collection("users").doc(user.id).set({
      'administrator': user.administrator,
      'disabled': user.disabled,
      'email': user.email,
      'id': user.id,
      'name': user.name
    });
  }

  ///Permite actualizar los datos del usuario identificado por medio del UID, en casos
  ///donde no todos los datos fueron alterados, el modelo del usuario guarda los datos
  ///anteririos y los sobreescrible.
  static void updateUser(User user) {
    _db.collection("users").doc(user.id).update({'name': user.name});
  }
}
