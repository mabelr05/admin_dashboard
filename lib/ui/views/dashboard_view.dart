import 'package:admin_dashboard/ui/app_colors.dart';
import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Panel', style: CustomLabels.h1),
          const SizedBox(height: 10),
          WhiteCard(title: user.nombre, child: Text(user.correo)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CardDashboard(cant: '1', description: 'Total en caja'),
              SizedBox(width: 10),
              CardDashboard(cant: '1', description: 'Total en caja'),
              SizedBox(width: 10),
              CardDashboard(cant: '1', description: 'Total en caja'),
              SizedBox(width: 10),
              CardDashboard(cant: '1', description: 'Total en caja'),
              // Repite lo mismo para los otros contenedores internos
            ],
          ),
        ],
      ),
    );
  }
}

class CardDashboard extends StatelessWidget {
  const CardDashboard({
    required this.cant,
    required this.description,
    Key? key,
  }) : super(key: key);
  final String cant;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          color: AppColor.kPrimary,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              cant,
              style: TextStyle(fontSize: 50, color: AppColor.kWhite),
            ),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: AppColor.kWhite),
            ),
          ],
        ),
      ),
    );
  }
}
