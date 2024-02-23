import 'package:admin_dashboard/models/monto.dart';
import 'package:admin_dashboard/providers/monto_provider.dart';
import 'package:admin_dashboard/ui/modals/monto_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MontoDTS extends DataTableSource {
  final List<Monto> montos;
  final BuildContext context;

  MontoDTS(this.montos, this.context);

  @override
  DataRow getRow(int index) {
    final monto = montos[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(monto.id)),
      DataCell(Text(monto.nombre)),
      DataCell(Row(
        children: [
          IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (_) => MontoModal(
                    monto: monto,
                  ),
                );
              }),
          IconButton(
              icon: Icon(Icons.delete_outline,
                  color: Colors.red.withOpacity(0.8)),
              onPressed: () {
                final dialog = AlertDialog(
                  title: const Text('Seguro que quieres borrarlo?'),
                  content: Text('Borrar definitivamente ${monto.nombre}?'),
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
                        await Provider.of<MontosProvider>(context,
                                listen: false)
                            .deleteMonto(monto.id);

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
  int get rowCount => montos.length;

  @override
  int get selectedRowCount => 0;
}
