import 'package:admin_dashboard/funtions.dart';
import 'package:admin_dashboard/models/gasto.dart';
import 'package:admin_dashboard/providers/gasto_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GastoDTS extends DataTableSource {
  final List<Gasto> gastos;
  final BuildContext context;

  GastoDTS(this.gastos, this.context);

  @override
  DataRow getRow(int index) {
    final gasto = gastos[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(gasto.concepto)),
      DataCell(Text(AppFormats.formatCurrency(gasto.monto))),
      DataCell(Text(AppFormats.formatFechaDdMMMyyyyHhMm(gasto.fecha))),
      DataCell(Text(AppFormats.formatFechaDdMMMyyyyHhMm(gasto.fechaRegistro))),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              // showModalBottomSheet(
              //   backgroundColor: Colors.transparent,
              //   context: context,
              //   builder: (_) => GastoModal(gasto: gasto),
              // );
            },
          ),
          IconButton(
            icon:
                Icon(Icons.delete_outline, color: Colors.red.withOpacity(0.8)),
            onPressed: () {
              final dialog = AlertDialog(
                title: const Text('¿Estás seguro que quieres borrarlo?'),
                content: Text(
                    '¿Borrar definitivamente el gasto de ${gasto.concepto}?'),
                actions: [
                  TextButton(
                    child: const Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Sí, borrar'),
                    onPressed: () async {
                      await Provider.of<GastosProvider>(context, listen: false)
                          .deleteGasto(gasto.id);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );

              showDialog(context: context, builder: (_) => dialog);
            },
          ),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => gastos.length;

  @override
  int get selectedRowCount => 0;
}
