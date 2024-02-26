import 'package:admin_dashboard/api/cafe_api.dart';
import 'package:admin_dashboard/models/http/cuotas_response.dart';
import 'package:admin_dashboard/models/cuota.dart';
import 'package:flutter/material.dart';

class CuotasProvider extends ChangeNotifier {
  List<Cuota> cuotas = [];

  getCuotas() async {
    final resp = await CafeApi.httpGet('/cuotas');
    final cuotasResp = CuotasResponse.fromMap(resp);

    cuotas = [...cuotasResp.cuotas];

    print(cuotas);

    notifyListeners();
  }

  Future newCuota(String name) async {
    final data = {'nombre': name};

    try {
      final json = await CafeApi.post('/cuota', data);
      final newCuota = Cuota.fromMap(json);

      cuotas.add(newCuota);
      notifyListeners();
    } catch (e) {
      throw 'Error al crear categoria';
    }
  }

  Future updateCuota(String id, String name) async {
    final data = {'nombre': name};

    try {
      await CafeApi.put('/cuota/$id', data);

      cuotas = cuotas.map((cuota) {
        if (cuota.id != id) return cuota;

        cuota.motivo = name;
        return cuota;
      }).toList();
      notifyListeners();
    } catch (e) {
      throw 'Error al crear categoria';
    }
  }

  Future deleteCuota(String id) async {
    try {
      await CafeApi.delete('/cuota/$id', {});

      cuotas.removeWhere((cuota) => cuota.id == id);

      notifyListeners();
    } catch (e) {
      print(e);
      print(' Error al crear la categoria');
    }
  }
}
