import 'package:admin_dashboard/funtions.dart';
import 'package:admin_dashboard/models/cuota.dart';
import 'package:admin_dashboard/providers/cuota_provider.dart';
import 'package:admin_dashboard/ui/modals/cuota_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CuotaDTS extends DataTableSource {
  final List<Cuota> cuotas;
  final BuildContext context;

  CuotaDTS(this.cuotas, this.context);

  @override
  DataRow getRow(int index) {
    final cuota = cuotas[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(cuota.id)),
      DataCell(Text(cuota.motivo)),
      DataCell(Text(AppFormats.formatCurrency(cuota.monto))),
      DataCell(Text(AppFormats.formatFechaDdMMMyyyyHhMm(cuota.fechaRegistro))),
      DataCell(Text(AppFormats.formatFechaDdMMMyyyyHhMm(cuota.fechaLimite))),
      DataCell(Row(
        children: [
          IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (_) => CuotaModal.CuotaModal(
                    cuota: cuota,
                  ),
                );
              }),
          IconButton(
              icon: Icon(Icons.delete_outline,
                  color: Colors.red.withOpacity(0.8)),
              onPressed: () {
                final dialog = AlertDialog(
                  title: const Text('Seguro que quieres borrarlo?'),
                  content: Text('Borrar definitivamente ${cuota.motivo}?'),
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
                        await Provider.of<CuotasProvider>(context,
                                listen: false)
                            .deleteCuota(cuota.id);

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
  int get rowCount => cuotas.length;

  @override
  int get selectedRowCount => 0;
}
