import 'dart:convert';

class Pago {
  String id;
  String idEstudiante;
  String nombreEstudiante;
  String email;
  double monto;
  DateTime fechaPago;
  String comprobante;
  String idCuota;
  String motivoCuota;
  String status;
  DateTime fechaActualizacionEstado;
  String? motivoRechazo;

  Pago({
    required this.id,
    required this.idEstudiante,
    required this.nombreEstudiante,
    required this.email,
    required this.monto,
    required this.fechaPago,
    required this.comprobante,
    required this.idCuota,
    required this.motivoCuota,
    required this.status,
    required this.fechaActualizacionEstado,
    this.motivoRechazo,
  });

  factory Pago.fromJson(String str) => Pago.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pago.fromMap(Map<String, dynamic> json) => Pago(
        id: json["_id"],
        idEstudiante: json["id_estudiante"],
        nombreEstudiante: json["nombre_estudiante"],
        email: json["email"],
        monto: json["monto"],
        fechaPago: DateTime.parse(json["fecha_pago"]),
        comprobante: json["comprobante"],
        idCuota: json["id_cuota"],
        motivoCuota: json["motivo_cuota"],
        status: json["status"],
        fechaActualizacionEstado:
            DateTime.parse(json["fecha_actualizacion_estado"]),
        motivoRechazo: json["motivo_rechazo"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "id_estudiante": idEstudiante,
        "nombre_estudiante": nombreEstudiante,
        "email": email,
        "monto": monto,
        "fecha_pago": fechaPago.toIso8601String(),
        "comprobante": comprobante,
        "id_cuota": idCuota,
        "motivo_cuota": motivoCuota,
        "status": status,
        "fecha_actualizacion_estado":
            fechaActualizacionEstado.toIso8601String(),
        "motivo_rechazo": motivoRechazo,
      };
}
