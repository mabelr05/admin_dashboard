import 'package:admin_dashboard/datatables/monto_datasource.dart';
import 'package:admin_dashboard/providers/monto_provider.dart';
import 'package:admin_dashboard/ui/modals/monto_modal.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:provider/provider.dart';

class MontosView extends StatefulWidget {
  const MontosView({Key? key}) : super(key: key);

  @override
  _MontosViewState createState() => _MontosViewState();
}

class _MontosViewState extends State<MontosView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();

    Provider.of<MontosProvider>(context, listen: false).getMonto();
  }

  @override
  Widget build(BuildContext context) {
    final montos = Provider.of<MontosProvider>(context).monto;

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
                  DataColumn(label: Text('Carrera')),
                   DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Acciones')),
                ],
                source: MontoDTS(montos, context),
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
                        builder: (context) => const MontoModal(),
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
                              TextStyle(color: Colors.white), 
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
