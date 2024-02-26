import 'dart:convert';

import '../pago.dart';

class PagosResponse {
    List<Pago> pagos;

    PagosResponse({
        required this.pagos,
    });

    factory PagosResponse.fromJson(String str) => PagosResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PagosResponse.fromMap(Map<String, dynamic> json) => PagosResponse(
        pagos: List<Pago>.from(json["pagos"].map((x) => Pago.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "pagos": List<dynamic>.from(pagos.map((x) => x.toMap())),
    };
}