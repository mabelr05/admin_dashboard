import 'dart:convert';

import '../usuario.dart';

class AuthResponse {
  Usuario usuario;
  String token;
  String? img;
  String? name;

  AuthResponse({
    required this.usuario,
    required this.token,
    this.img,
    this.name,
  });

  factory AuthResponse.fromJson(String str) =>
      AuthResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthResponse.fromMap(Map<String, dynamic> json) => AuthResponse(
      usuario: Usuario.fromMap(json["usuario"]),
      token: json["token"],
      img: json["usuario"]
          ["img"], // Acceder correctamente al valor img dentro de usuario
      name: json["usuario"]
          ["nombre"] // Acceder correctamente al valor nombre dentro de usuario
      );

  Map<String, dynamic> toMap() =>
      {"usuario": usuario.toMap(), "token": token, "img": img, "nombre": name};
}
