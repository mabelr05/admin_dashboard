import 'package:admin_dashboard/models/usuario.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:flutter/material.dart';

class  UsersDataSource extends DataTableSource {  

  final List<Usuario> users;

  UsersDataSource(this.users);

  @override
  DataRow getRow(int index) {

    final Usuario user = users[index];

    final image = ( user.img == null)
      ? const Image(image: AssetImage('no-image.jpg'), width: 35, height: 35,)
      : FadeInImage.assetNetwork(placeholder: 'loader.gif', image: user.img!, width: 35, height: 35,);

   return DataRow.byIndex(
    index: index,
    cells: [
      DataCell(
        ClipOval(child: image,)
        ),
      DataCell(Text(user.nombre)),
      DataCell(Text(user.correo)),
      DataCell(Text(user.uid)),
      DataCell(
        IconButton(
        icon: const Icon ( Icons.edit_outlined),
        onPressed: (){
          //TODO: Navegar a una nueva pantalla con el /UID
          NavigationService.replaceTo('/dashboard/users/${user.uid}');        
          }
        )
      ),

    ]
    );
  }

  @override
  
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => users.length;

  @override

  int get selectedRowCount => 0;
}
