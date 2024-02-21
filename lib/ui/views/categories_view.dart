import 'package:admin_dashboard/datatables/categories_datasource.dart';
import 'package:admin_dashboard/providers/categories_provider.dart';
import 'package:admin_dashboard/ui/modals/categoria_modal.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:provider/provider.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();

    Provider.of<CategoriesProvider>(context, listen: false).getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final categorias = Provider.of<CategoriesProvider>(context).categorias;

    return Builder(
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              Text('Categorias', style: CustomLabels.h1),
              const SizedBox(height: 10),
              PaginatedDataTable(
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Carrera')),
                  DataColumn(label: Text('Acciones')),
                ],
                source: CategoriesDTS(categorias, context),
                header: const Text('Categorias disponibles', maxLines: 2),
                onRowsPerPageChanged: (value) {
                  setState(() {
                    _rowsPerPage = value ?? 10;
                  });
                },
                rowsPerPage: _rowsPerPage,
                actions: [
                  ElevatedButton(
  onPressed: () {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => const CategoriaModal(),
    );
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.teal, // Color del botón
  ),
  child: const Row(
    children: [
      Text('Crear'),
      Icon(Icons.add_outlined),
    ],
  ),
)
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
