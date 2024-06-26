import 'package:admin_dashboard/datatables/categories_datasource.dart';
import 'package:admin_dashboard/providers/categories_provider.dart';
import 'package:admin_dashboard/ui/modals/categoria_modal.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:provider/provider.dart';

class CarrerasView extends StatefulWidget {
  const CarrerasView({Key? key}) : super(key: key);

  @override
  _CarrerasViewState createState() => _CarrerasViewState();
}

class _CarrerasViewState extends State<CarrerasView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();

    Provider.of<CarrerasProvider>(context, listen: false).getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final categorias = Provider.of<CarrerasProvider>(context).categorias;
    //print(categorias);

    return Builder(
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              Text('Carreras', style: CustomLabels.h1),
              const SizedBox(height: 10),
              PaginatedDataTable(
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Carrera')),
                  DataColumn(label: Text('Acciones')),
                ],
                source: CategoriesDTS(categorias, context),
                header: const Text('Carreras disponibles', maxLines: 2),
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
                      backgroundColor: Colors.indigo, // Color del botón
                    ),
                    child: const Row(
                      children: [
                        Text(
                          'Crear',
                          style:
                              TextStyle(color: Colors.white), // Dale color aquí
                        ),
                        Icon(Icons.add_outlined, color: Colors.white),
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
