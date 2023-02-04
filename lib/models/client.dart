import 'dart:convert';

///Éste objeto corresponde a un cliente de la base de datos con todos sus respectivos
///atributos.
class Client {
  ///Método constructor de cliente, requiere de algunos atrubutos para ser construido.
  Client(
      {required this.email1,
      this.email2 = "N/A",
      this.enterprise = "N/A",
      this.enterpriseIdentification = "N/A",
      required this.identification,
      required this.identificationType,
      this.imageUrl = "N/A",
      required this.name,
      required this.number1,
      this.number2 = 0});

  String email1;
  String email2;
  String enterprise;
  String enterpriseIdentification;
  String identification;
  int identificationType;
  String imageUrl;
  String name;
  int number1;
  int number2;

  factory Client.fromJson(String str) => Client.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  ///Éste método recibe un objeto de tipo Map de la base de datos que corresponde a la interptretación
  ///de un archivo json el cual es el cliente, y lo convierte a un objeto de tipo Client para luego ser
  ///usado.
  factory Client.fromMap(Map<String, dynamic> json) => Client(
      email1: json["email1"] ?? "N/A",
      email2: json["email2"] ?? "N/A",
      enterprise: json["enterprise"] ?? "N/A",
      enterpriseIdentification: json["enterpriseIdentification"] ?? "N/A",
      identification: json["identification"] ?? "N/A",
      identificationType: json["identificationType"] ?? 0,
      imageUrl: json["imageUrl"] ?? "N/A",
      name: json["name"] ?? "N/A",
      number1: json["number1"] ?? 0,
      number2: json["number2"] ?? 0);

  Map<String, dynamic> toMap() => {
        "email1": email1,
        "email2": email2,
        "enterprise": enterprise,
        "enterpriceIdentification": enterpriseIdentification,
        "identification": identification,
        "identificationType": identificationType,
        "imageUrl": imageUrl,
        "name": name,
        "number1": number1,
        "number2": number2
      };
}
