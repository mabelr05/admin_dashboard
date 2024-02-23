import 'dart:convert';

class Monto {
    Monto({
        required this.id,
        required this.nombre,
        required this.usuario,
    });

    String id;
    String nombre;
    _Usuario usuario;

    factory Monto.fromJson(String str) => Monto.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Monto.fromMap(Map<String, dynamic> json) => Monto(
        id: json["_id"],
        nombre: json["nombre"],
        usuario: _Usuario.fromMap(json["usuario"]),
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "nombre": nombre,
        "usuario": usuario.toMap(),
    };

    @override
  String toString() {
    return 'Monto: $nombre';
  }
}

class _Usuario {
    String id;
    String nombre;

    _Usuario({
        required this.id,
        required this.nombre,
    });

    factory _Usuario.fromJson(String str) => _Usuario.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory _Usuario.fromMap(Map<String, dynamic> json) => _Usuario(
        id: json["_id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "nombre": nombre,
    };
}
