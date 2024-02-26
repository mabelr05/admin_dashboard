import 'package:admin_dashboard/datatables/gastos_datasource.dart';
import 'package:admin_dashboard/providers/gasto_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../services/notifications_service.dart'; // Importar el paquete image_picker

class GastosView extends StatefulWidget {
  const GastosView({Key? key}) : super(key: key);

  @override
  _GastosViewState createState() => _GastosViewState();
}

class _GastosViewState extends State<GastosView> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _conceptoController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  late GastosProvider gastosProvider; // Define gastosProvider here

  @override
  void initState() {
    super.initState();
    // Fetch initial data
    gastosProvider = Provider.of<GastosProvider>(context, listen: false);
    gastosProvider.getGastos(); // Call getGastos method
  }

  @override
  Widget build(BuildContext context) {
    final gastos = Provider.of<GastosProvider>(context)
        .gastos; // Access gastos from gastosProvider
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              PaginatedDataTable(
                columns: const [
                  DataColumn(label: Text('Concepto')),
                  DataColumn(label: Text('Valor')),
                  DataColumn(label: Text('Fecha')),
                  DataColumn(label: Text('Fecha de Registro')),
                  DataColumn(label: Text('Acciones')),
                ],
                source: GastoDTS(gastos, context),
                header: const Text('Gastos Registrados', maxLines: 2),
                onRowsPerPageChanged: (value) {
                  setState(() {
                    _rowsPerPage = value ?? 10;
                  });
                },
                rowsPerPage: _rowsPerPage,
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Crear Gasto'),
                            contentPadding: const EdgeInsets.all(16.0),
                            content: SingleChildScrollView(
                              child: GastoFormWidget(
                                amountController: _amountController,
                                conceptoController: _conceptoController,
                                dateController: _dateController,
                                onDateSelected: (DateTime selectedDate) {
                                  print('Fecha seleccionada: $selectedDate');
                                },
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancelar'),
                              ),
                              ElevatedButton(
                                onPressed: _registrarGasto,
                                child: const Text('Registrar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.add_outlined, color: Colors.white),
                        Text(
                          'Crear Gasto',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _registrarGasto() async {
    final String concepto = _conceptoController.text;
    final String amountStr = _amountController.text;
    final double amount = double.parse(amountStr);
    final String dateStr = _dateController.text;
    final DateTime date = DateFormat("yyyy-MM-dd").parse(dateStr);

    // Ensure necessary variables are defined and accessible
    try {
      // Crear
      await gastosProvider.newGasto(
        concepto,
        amount,
        date,
      );
      NotificationsService.showSnackbar('$concepto creado!');
      Navigator.of(context).pop();
      setState(() {});
    } catch (e) {
      NotificationsService.showSnackbarError('No se pudo guardar la categoría');
    }
  }
}

class GastoFormWidget extends StatefulWidget {
  final TextEditingController amountController;
  final TextEditingController conceptoController;
  final TextEditingController dateController;
  final void Function(DateTime)? onDateSelected;

  const GastoFormWidget({
    Key? key,
    required this.amountController,
    required this.conceptoController,
    this.onDateSelected,
    required this.dateController,
  }) : super(key: key);

  @override
  _GastoFormWidgetState createState() => _GastoFormWidgetState();
}

class _GastoFormWidgetState extends State<GastoFormWidget> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: widget.amountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            hintText: '\$0.0',
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              final numericValue = double.parse(value);
              final formattedValue =
                  NumberFormat.currency(locale: 'en_US', symbol: '\$')
                      .format(numericValue);
              if (value != formattedValue) {
                widget.amountController.value =
                    widget.amountController.value.copyWith(
                  text: formattedValue.substring(1),
                  selection:
                      TextSelection.collapsed(offset: formattedValue.length),
                  composing: TextRange.empty,
                );
              }
            }
          },
        ),
        TextField(
          controller: widget.conceptoController,
          decoration: const InputDecoration(labelText: 'Concepto'),
        ),
        TextField(
          controller: widget.dateController,
          decoration: const InputDecoration(labelText: 'Fecha de gasto'),
          maxLines: null,
          style: const TextStyle(fontSize: 14),
          onTap: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              //locale: const Locale('es', 'ES'),
            );

            if (pickedDate != null) {
              setState(() {
                _selectedDate = pickedDate;
                widget.onDateSelected?.call(pickedDate);
                widget.dateController.text =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
              });
            }
          },
        ),
      ],
    );
  }
}
