import 'package:admin_dashboard/funtions.dart';
import 'package:admin_dashboard/models/pago.dart';
import 'package:admin_dashboard/providers/pago_provider.dart';
import 'package:admin_dashboard/ui/modals/pago_modal.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PagoDTS extends DataTableSource {
  final List<Pago> pagos;
  final BuildContext context;

  PagoDTS(this.pagos, this.context);

  @override
  DataRow getRow(int index) {
    final pago = pagos[index];

    return DataRow.byIndex(index: index, cells: [
      //DataCell(Text(pago.id)),
      DataCell(Text(pago.motivoCuota)),
      DataCell(Text(pago.nombreEstudiante)),
      DataCell(Text(pago.email)),
      DataCell(Text(AppFormats.formatCurrency(pago.monto))),
      DataCell(Text(pago.status)),
      DataCell(Text(AppFormats.formatFechaDdMMMyyyyHhMm(pago.fechaPago))),
      DataCell(Row(
        children: [
          IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (_) => PagoModal.PagoModal(
                    pago: pago,
                  ),
                );
              }),
          IconButton(
              icon: Icon(Icons.delete_outline,
                  color: Colors.red.withOpacity(0.8)),
              onPressed: () {
                final dialog = AlertDialog(
                  title: const Text('Seguro que quieres borrarlo?'),
                  content: Text(
                      'Borrar definitivamente el pago de ${pago.nombreEstudiante}?'),
                  actions: [
                    TextButton(
                      child: const Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text('Si, borrar'),
                      onPressed: () async {
                        await Provider.of<PagosProvider>(context, listen: false)
                            .deletePago(pago.id);

                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );

                showDialog(context: context, builder: (_) => dialog);
              }),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => pagos.length;

  @override
  int get selectedRowCount => 0;
}
