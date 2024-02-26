import 'dart:convert';

import '../cuota.dart';

class CuotasResponse {
    List<Cuota> cuotas;

    CuotasResponse({
        required this.cuotas,
    });

    factory CuotasResponse.fromJson(String str) => CuotasResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CuotasResponse.fromMap(Map<String, dynamic> json) => CuotasResponse(
        cuotas: List<Cuota>.from(json["cuotas"].map((x) => Cuota.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "cuotas": List<dynamic>.from(cuotas.map((x) => x.toMap())),
    };
}