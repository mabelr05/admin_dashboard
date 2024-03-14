import 'package:admin_dashboard/datatables/pagos_datasource.dart';
import 'package:admin_dashboard/providers/pago_provider.dart';
import 'package:admin_dashboard/ui/modals/pago_modal.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:provider/provider.dart';

class PagosView extends StatefulWidget {
  const PagosView({Key? key}) : super(key: key);

  @override
  _PagosViewState createState() => _PagosViewState();
}

class _PagosViewState extends State<PagosView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  String _selectedStatus = 'Todos';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    Provider.of<PagosProvider>(context, listen: false).getPagos();
  }

  @override
  Widget build(BuildContext context) {
    final pagosProvider = Provider.of<PagosProvider>(context);
    final pagos = pagosProvider.pagos.where((pago) {
      final matchesStatus =
          _selectedStatus == 'Todos' || pago.status == _selectedStatus;
      final matchesSearch = _searchQuery.isEmpty ||
          pago.nombreEstudiante
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());
      return matchesStatus && matchesSearch;
    }).toList();

    return Builder(
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pagos', style: CustomLabels.h1),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSearchField(),
                    const SizedBox(width: 50),
                    _buildFilterDropdown(),
                  ],
                ),
                const SizedBox(height: 10),
                PaginatedDataTable(
                  columns: const [
                    DataColumn(label: Text('Motivo')),
                    DataColumn(label: Text('Estudiante')),
                    DataColumn(label: Text('Correo')),
                    DataColumn(label: Text('Monto')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Fecha de Pago')),
                    DataColumn(label: Text('Acciones')),
                  ],
                  source: PagoDTS(pagos, context),
                  header: const Text('Pagos disponibles', maxLines: 2),
                  onRowsPerPageChanged: (value) {
                    setState(() {
                      _rowsPerPage = value ?? 10;
                    });
                  },
                  rowsPerPage: _rowsPerPage,
                  actions: [
                    // ElevatedButton(
                    //   onPressed: () {
                    //     showModalBottomSheet(
                    //       backgroundColor: Colors.transparent,
                    //       context: context,
                    //       builder: (context) => const PagoModal.PagoModal(),
                    //     );
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors.indigo,
                    //   ),
                    //   child: const Row(
                    //     children: [
                    //       Text('Crear Pago',
                    //           style: TextStyle(color: Colors.white)),
                    //       Icon(Icons.add_outlined, color: Colors.white),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterDropdown() {
    return DropdownButton<String>(
      value: _selectedStatus,
      onChanged: (value) {
        setState(() {
          _selectedStatus = value!;
        });
      },
      items: ['Todos', 'Pendiente', 'Aprobado', 'Rechazado']
          .map((status) => DropdownMenuItem<String>(
                value: status,
                child: Text(status),
              ))
          .toList(),
    );
  }

  Widget _buildSearchField() {
    return Expanded(
      child: TextField(
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        decoration: const InputDecoration(
          hintText: 'Buscar por nombre',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
