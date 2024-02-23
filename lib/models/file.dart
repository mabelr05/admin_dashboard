import 'dart:convert';

class File {
  String nombre;

  File({
    required this.nombre,
  });

  factory File.fromJson(String str) =>
      File.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory File.fromMap(Map<String, dynamic> json) => File(
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() => {
        "nombre": nombre,
      };
}
