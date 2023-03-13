import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hotel_primavera_app/services/services.dart';

///Permite establecer la conexión entre la aplicación y el apartado de almacenamiendo
///de la base de datos. Este apartado es usado exclusivamente para el almacenamiento de iamgenes,
///principalmente de los clientes.
class FirebaseStorageService {
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  ///Permite cargar una nueva imagen a la base de datos, esta es asociada a su cliente de dos formas.
  ///Primeramente se guarda con el nombre de identificación alfanumerico del cliente al que corresponde y
  ///al cliente se le asigna la url con la cual puede acceder a la imagen. además permite la actualización
  ///simplemente sobresescribe la imagen.
  static uploadProductFile(String path, String name) async {
    File file = File(path);
    try {
      await _storage.ref('clients/$name').putFile(file);
    } catch (e) {
      NotificationsService.showErrorSnackbar(
          "Ha ocurrido un error a la hora se subir la nueva imagen. Por favor, inmtentelo de nuevo.");
    }
    try {
      String url = await _storage.ref('products/$name').getDownloadURL();
      FirebaseDatabaseService.setClientImagUrl(clientId: path, imageUrl: url);
    } catch (e) {
      NotificationsService.showErrorSnackbar(
          "Ha ocurrido un error a la hora de cargar la nueva imagen. Por favor, inmtentelo de nuevo.");
    }
  }
}
