import 'package:intl/intl.dart';

class AppFormats {
  static String formatCurrency(double amount) {
    return '\$ ${amount.toStringAsFixed(2)}'; // Formato básico de moneda
  }

  static String formatFechaDdMMMyyyyHhMm(DateTime fecha) {
    // Restar 5 horas a la fecha
    fecha = fecha.subtract(const Duration(hours: 5));

    // Crear un formato de fecha personalizado
    DateFormat formato = DateFormat('dd/MMM/yyyy hh:mm a');

    // Formatear la fecha y devolverla como una cadena
    return formato.format(fecha);
  }
}
