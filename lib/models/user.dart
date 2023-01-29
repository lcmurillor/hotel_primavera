import 'dart:convert';

///Éste objeto corresponde a un usuario de la base de datos con todos sus respectivos
///atributos.
class User {
  ///Método constructor de usarios, requiere de todos los atrubutos para ser construido.
  User(
      {this.administrator = false,
      this.disabled = false,
      required this.email,
      required this.id,
      required this.name});

  bool administrator;
  bool disabled;
  String email;
  String id;
  String name;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  ///Éste método recibe un objeto de tipo Map de la base de datos que corresponde a la interptretación
  ///de un archivo json el cual es el usuario, y lo convierte a un objeto de tipo User para luego ser
  ///usado.
  factory User.fromMap(Map<String, dynamic> json) => User(
      administrator: json["administrator"] ?? false,
      disabled: json["disabled"] ?? false,
      email: json["email"] ?? 'undefined',
      id: json["id"] ?? 'undefined',
      name: json["name"] ?? 'undefined');

  Map<String, dynamic> toMap() => {
        "administrator": administrator,
        "disabled": disabled,
        "email": email,
        "id": id,
        "name": name
      };
}
