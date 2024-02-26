import 'dart:convert';

class Cuota {
    String id;
    String motivo;
    double monto;
    DateTime fechaRegistro;
    DateTime fechaLimite;

    Cuota({
        required this.id,
        required this.motivo,
        required this.monto,
        required this.fechaRegistro,
        required this.fechaLimite,
    });

    factory Cuota.fromJson(String str) => Cuota.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Cuota.fromMap(Map<String, dynamic> json) => Cuota(
        id: json["_id"],
        motivo: json["motivo"],
        monto: json["monto"]?.toDouble(),
        fechaRegistro: DateTime.parse(json["fecha_registro"]),
        fechaLimite: DateTime.parse(json["fecha_limite"]),
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "motivo": motivo,
        "monto": monto,
        "fecha_registro": fechaRegistro.toIso8601String(),
        "fecha_limite": fechaLimite.toIso8601String(),
    };
}