import 'package:admin_dashboard/api/cafe_api.dart';
import 'package:admin_dashboard/models/http/gastos_response.dart';
import 'package:admin_dashboard/models/gasto.dart';
import 'package:flutter/material.dart';

class GastosProvider extends ChangeNotifier {
  List<Gasto> gastos = [];

  // Método para obtener todos los gastos
  getGastos() async {
    try {
      // Realizar solicitud HTTP para obtener los gastos
      final resp = await CafeApi.httpGet('/gastos');

      // Convertir la respuesta en un objeto GastosResponse
      final gastosResp = GastosResponse.fromMap(resp);

      // Actualizar la lista de gastos con los recibidos de la API
      gastos = [...gastosResp.gastos];

      // Imprimir los gastos en la consola para depuración
      print(gastos);

      // Notificar a los oyentes que se han obtenido nuevos gastos
      notifyListeners();
    } catch (e) {
      // Capturar y manejar cualquier error que ocurra durante la obtención de gastos
      print('Error al obtener los gastos: $e');
    }
  }

  // Método para crear un nuevo gasto
  Future newGasto(
    String concepto,
    double monto,
    DateTime fecha,
  ) async {
    final data = {
      'concepto': concepto,
      'monto': monto,
      'fecha': fecha.toIso8601String(),
    };
    print(data);
    try {
      // Realizar solicitud HTTP para crear un nuevo gasto
      final json = await CafeApi.post('/gastos', data);

      // Convertir la respuesta en un objeto Gasto
      final newGasto = Gasto.fromMap(json);

      // Agregar el nuevo gasto a la lista de gastos
      gastos.add(newGasto);

      // Notificar a los oyentes que se ha creado un nuevo gasto
      notifyListeners();
    } catch (e) {
      // Capturar y manejar cualquier error que ocurra durante la creación del gasto
      throw 'Error al crear el gasto: $e';
    }
  }

  // Método para eliminar un gasto existente
  Future deleteGasto(String id) async {
    try {
      // Realizar solicitud HTTP para eliminar el gasto
      await CafeApi.delete('/gastos/$id', {});

      // Eliminar el gasto de la lista de gastos localmente
      gastos.removeWhere((gasto) => gasto.id == id);

      // Notificar a los oyentes que se ha eliminado un gasto
      notifyListeners();
    } catch (e) {
      // Capturar y manejar cualquier error que ocurra durante la eliminación del gasto
      print('Error al eliminar el gasto: $e');
    }
  }
}
