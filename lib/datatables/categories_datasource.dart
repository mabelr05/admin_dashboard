import 'package:admin_dashboard/models/categoria.dart';
import 'package:flutter/material.dart';

class CategoriesDTS extends DataTableSource{

  final List<Categoria> categorias;
  final BuildContext contex;

  CategoriesDTS(this.categorias, this.contex);

  @override
  DataRow getRow(int index){

    final categoria = this.categorias[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell( Text( categoria.id)),
        DataCell( Text( categoria.nombre)),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit_outlined),
                onPressed: () {
                  print('editando: $categoria');
                }

              ),
              IconButton(
                icon: Icon (Icons.delete_outline, color: Colors.red.withOpacity(0.8)),
                onPressed: () {
                  
                  final dialog = AlertDialog(
                    title: Text('Seguro que quieres borrarlo?'),
                    content: Text('Borrar definitivamente ${ categoria.nombre}?'),
                    actions: [
                      TextButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.of(contex).pop();
                        },
                        ),
                        TextButton(
                          child: Text('Si, borrar'),
                          onPressed: () {
                            Navigator.of(contex).pop();
                          },
                          )
                    ],
                  );
                  
                  showDialog(
                    context: contex, 
                    builder: (_) => dialog);

                }
              ),
            ],
          ) 
        ),
      ]
    );
  }              
  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => categorias.length;

  @override
  int get selectedRowCount => 0;
  

}