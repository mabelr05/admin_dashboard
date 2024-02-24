import 'package:admin_dashboard/api/cafe_api.dart';
import 'package:admin_dashboard/models/http/montos_response.dart';
import 'package:admin_dashboard/models/monto.dart';
import 'package:flutter/material.dart';

class MontosProvider extends ChangeNotifier{

  List <Monto> monto = [];

  getMonto() async{
    final resp = await CafeApi.httpGet('/monto');
    final montoResp = MontoResponse.fromMap(resp);

    monto = [...montoResp.montos];

    print(monto);

    notifyListeners();
  }

  Future newMonto( String name) async{

    final data = {
      'nombre' : name
    };

    try{

      final json = await CafeApi.post('/monto', data);
      final newMonto = Monto.fromMap(json);

      monto.add( newMonto);
      notifyListeners();

    }catch (e) {
      throw 'Error al crear categoria';
    }
  }

   Future updateMonto(String id, String name) async{

    final data = {
      'nombre' : name
    };

    try{

      await CafeApi.put('/monto/$id', data);

      monto = monto.map(
        (monto) {
          if (monto.id != id) return monto;

          monto.nombre= name;
          return monto;
        }
      ).toList();
      notifyListeners();

    }catch (e) {
      throw 'Error al crear categoria';
    }
  }

  Future deleteMonto(String id) async{

    try{

      await CafeApi.delete('/monto/$id', {});

      monto.removeWhere((monto) => monto.id == id);
        
      notifyListeners();

    }catch (e) {
      print(e);
      print(' Error al crear la categoria');
    }
  }
}