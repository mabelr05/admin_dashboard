import 'dart:convert';

class Gasto {
  String id;
  String concepto;
  double monto;
  DateTime fecha;
  DateTime fechaRegistro;

  Gasto({
    required this.id,
    required this.concepto,
    required this.monto,
    required this.fecha,
    required this.fechaRegistro,
  });

  factory Gasto.fromJson(String str) => Gasto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Gasto.fromMap(Map<String, dynamic> json) => Gasto(
        id: json["_id"],
        concepto: json["concepto"],
        monto: json["monto"]?.toDouble(),
        fecha: DateTime.parse(json["fecha"]),
        fechaRegistro: DateTime.parse(json["fecha_registro"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "concepto": concepto,
        "monto": monto,
        "fecha": fecha.toIso8601String(),
        "fecha_registro": fechaRegistro.toIso8601String(),
      };
}
