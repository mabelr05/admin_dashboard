import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';

class NotificationsIndicator extends StatelessWidget {
  const NotificationsIndicator({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user!;
    return Container(
      child: Stack(
        children: [
         Text(user.nombre.toUpperCase(),style: const TextStyle(fontWeight: FontWeight.bold),),
          //Positioned(
          //  left: 2, //Para posicionar la campana
          //  child: Container(
          //  width: 5,
          //  height: 5,
          //  decoration: buildBoxDecoration(),
          //           ),
          //)
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
    color: Colors.red,
    borderRadius: BorderRadius.circular(100)
  );
}