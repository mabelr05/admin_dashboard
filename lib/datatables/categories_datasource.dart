import 'package:admin_dashboard/models/categoria.dart';
import 'package:admin_dashboard/providers/categories_provider.dart';
import 'package:admin_dashboard/ui/modals/categoria_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesDTS extends DataTableSource {
  final List<Categoria> categorias;
  final BuildContext context;

  CategoriesDTS(this.categorias, this.context);

  @override
  DataRow getRow(int index) {
    final categoria = categorias[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(categoria.id)),
      DataCell(Text(categoria.nombre)),
      DataCell(Row(
        children: [
          IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (_) => CategoriaModal(
                    categoria: categoria,
                  ),
                );
              }),
          IconButton(
              icon: Icon(Icons.delete_outline,
                  color: Colors.red.withOpacity(0.8)),
              onPressed: () {
                final dialog = AlertDialog(
                  title: const Text('Seguro que quieres borrarlo?'),
                  content: Text('Borrar definitivamente ${categoria.nombre}?'),
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
                        await Provider.of<CategoriesProvider>(context,
                                listen: false)
                            .deleteCategoria(categoria.id);

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
  int get rowCount => categorias.length;

  @override
  int get selectedRowCount => 0;
}
