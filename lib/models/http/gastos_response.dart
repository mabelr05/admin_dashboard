import 'dart:convert';

import '../gasto.dart';

class GastosResponse {
    List<Gasto> gastos;

    GastosResponse({
        required this.gastos,
    });

    factory GastosResponse.fromJson(String str) => GastosResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GastosResponse.fromMap(Map<String, dynamic> json) => GastosResponse(
        gastos: List<Gasto>.from(json["gastos"].map((x) => Gasto.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "gastos": List<dynamic>.from(gastos.map((x) => x.toMap())),
    };
}
