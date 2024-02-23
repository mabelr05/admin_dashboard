import 'dart:convert';

import '../monto.dart';

class MontoResponse {
    int total;
    List<Monto> montos;

    MontoResponse({
        required this.total,
        required this.montos,
    });

    factory MontoResponse.fromJson(String str) => MontoResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MontoResponse.fromMap(Map<String, dynamic> json) => MontoResponse(
        total: json["total"],
        montos: List<Monto>.from(json["Montos"].map((x) => Monto.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "total": total,
        "Montos": List<dynamic>.from(montos.map((x) => x.toMap())),
    };
}

