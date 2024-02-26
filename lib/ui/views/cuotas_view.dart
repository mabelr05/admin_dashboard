import 'package:admin_dashboard/datatables/cuotas_datasource.dart';
import 'package:admin_dashboard/providers/cuota_provider.dart';
import 'package:admin_dashboard/ui/modals/cuota_modal.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:provider/provider.dart';

class CuotasView extends StatefulWidget {
  const CuotasView({Key? key}) : super(key: key);

  @override
  _CuotasViewState createState() => _CuotasViewState();
}

class _CuotasViewState extends State<CuotasView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();

    Provider.of<CuotasProvider>(context, listen: false).getCuotas();
  }

  @override
  Widget build(BuildContext context) {
    final cuotas = Provider.of<CuotasProvider>(context).cuotas;

    return Builder(
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              Text('Cuotas', style: CustomLabels.h1),
              const SizedBox(height: 10),
              PaginatedDataTable(
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Motivo')),
                  DataColumn(label: Text('Monto')),
                  DataColumn(label: Text('Fecha de registro')),
                  DataColumn(label: Text('Fecha limite')),
                  DataColumn(label: Text('Acciones')),
                ],
                source: CuotaDTS(cuotas, context),
                header: const Text('Cuotas disponibles', maxLines: 2),
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
                        builder: (context) => const CuotaModal.CuotaModal(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo, // Color del botón
                    ),
                    child: const Row(
                      children: [
                        Text(
                          'Crear Cuota',
                          style: TextStyle(color: Colors.white),
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
