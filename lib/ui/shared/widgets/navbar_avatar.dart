import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavbarAvatar extends StatelessWidget {
  const NavbarAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user!;
    String imagePath = user.img != null ? user.img! : 'assets/no-image.jpg';
    return ClipOval(
      //Hace circular la imagen
      child: SizedBox(
        width: 30,
        height: 30,
        child: Image.network(imagePath),
      ),
    );
  }
}
