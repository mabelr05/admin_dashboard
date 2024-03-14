import 'package:admin_dashboard/api/cafe_api.dart';
import 'package:admin_dashboard/models/http/pagos_response.dart';
import 'package:admin_dashboard/models/pago.dart';
import 'package:flutter/material.dart';

class PagosProvider extends ChangeNotifier {
  List<Pago> pagos = [];

  // Método para obtener todos los pagos
  getPagos() async {
    try {
      // Realizar solicitud HTTP para obtener los pagos
      final resp = await CafeApi.httpGet('/pagos');

      // Convertir la respuesta en un objeto PagosResponse
      final pagosResp = PagosResponse.fromMap(resp);

      // Actualizar la lista de pagos con los recibidos de la API
      pagos = [...pagosResp.pagos];

      // Imprimir los pagos en la consola para depuración
      print(pagos);

      // Notificar a los oyentes que se han obtenido nuevos pagos
      notifyListeners();
    } catch (e) {
      // Capturar y manejar cualquier error que ocurra durante la obtención de pagos
      print('Error al obtener los pagos: $e');
    }
  }

  // Método para crear un nuevo pago
  Future newPago(String idEstudiante, String nombreEstudiante, String email,
      double monto, String comprobante, String idCuota) async {
    final data = {
      'id_estudiante': idEstudiante,
      'nombre_estudiante': nombreEstudiante,
      'email': email,
      'monto': monto,
      'comprobante': comprobante,
      'id_cuota': idCuota
    };

    try {
      // Realizar solicitud HTTP para crear un nuevo pago
      final json = await CafeApi.post('/pagos', data);

      // Convertir la respuesta en un objeto Pago
      final newPago = Pago.fromMap(json);

      // Agregar el nuevo pago a la lista de pagos
      pagos.add(newPago);

      // Notificar a los oyentes que se ha creado un nuevo pago
      notifyListeners();
    } catch (e) {
      // Capturar y manejar cualquier error que ocurra durante la creación del pago
      throw 'Error al crear el pago: $e';
    }
  }

  // Método para actualizar un pago existente
  Future updatePago(String id, String status, String? motivoRechazo) async {
    // Crear un mapa para los datos de la solicitud
    final Map<String, dynamic> data = {'status': status};

    // Si el motivo de rechazo no es nulo, incluirlo en los datos de la solicitud
    if (motivoRechazo != null) {
      data['motivo_rechazo'] = motivoRechazo;
    }

    try {
      // Realizar solicitud HTTP para actualizar el pago
      await CafeApi.put('/pagos/$id', data);

      // Actualizar la lista de pagos localmente
      pagos = pagos.map((pago) {
        if (pago.id != id) return pago;

        pago.status = status;
        pago.motivoRechazo = motivoRechazo;
        return pago;
      }).toList();

      // Notificar a los oyentes que se ha actualizado un pago
      notifyListeners();
    } catch (e) {
      // Capturar y manejar cualquier error que ocurra durante la actualización del pago
      throw 'Error al actualizar el pago: $e';
    }
  }

  // Método para eliminar un pago existente
  Future deletePago(String id) async {
    try {
      // Realizar solicitud HTTP para eliminar el pago
      await CafeApi.delete('/pagos/$id', {});

      // Eliminar el pago de la lista de pagos localmente
      pagos.removeWhere((pago) => pago.id == id);

      // Notificar a los oyentes que se ha eliminado un pago
      notifyListeners();
    } catch (e) {
      // Capturar y manejar cualquier error que ocurra durante la eliminación del pago
      print('Error al eliminar el pago: $e');
    }
  }
}
