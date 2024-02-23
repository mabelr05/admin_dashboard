import 'package:intl/intl.dart';

// Función para convertir la fecha en formato legible
String convertirFechaLegible(DateTime fecha) {
  // Restar 5 horas a la fecha
  fecha = fecha.subtract(Duration(hours: 5));

  // Crear un formato de fecha personalizado
  DateFormat formato = DateFormat('dd/MMM/yyyy hh:mm a');

  // Formatear la fecha y devolverla como una cadena
  return formato.format(fecha);
}
