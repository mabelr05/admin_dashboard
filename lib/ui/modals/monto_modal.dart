import 'package:admin_dashboard/models/monto.dart';
import 'package:admin_dashboard/providers/monto_provider.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MontoModal extends StatefulWidget {
  final Monto? monto;

  const MontoModal({Key? key, this.monto}) : super(key: key);

  @override
  MontoModalState createState() => MontoModalState();
}

class MontoModalState extends State<MontoModal> {
  String nombre = '';
  String? id;

  @override
  void initState() {
    super.initState();

    id = widget.monto?.id;
    nombre = widget.monto?.nombre ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final montoProvider =
        Provider.of<MontosProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(20),
      height: 500,
      width: MediaQuery.of(context).size.width, // expanded
      decoration: buildBoxDecoration(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.monto?.nombre ?? 'Nueva categoría',
                  style: CustomLabels.h1.copyWith(color: Colors.white)),
              IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.of(context).pop())
            ],
          ),
          Divider(color: Colors.white.withOpacity(0.3)),
          const SizedBox(height: 20),
          TextFormField(
            initialValue: widget.monto?.nombre ?? '',
            onChanged: (value) => nombre = value,
            decoration: CustomInputs.loginInputDecoration(
                hint: 'Nombre de la categoría',
                label: 'Categoría',
                icon: Icons.new_releases_outlined),
            style: const TextStyle(color: Colors.white),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: CustomOutlinedButton(
              onPressed: () async {
                try {
                  if (id == null) {
                    // Crear
                    await montoProvider.newMonto(nombre);
                    NotificationsService.showSnackbar('$nombre creado!');
                  } else {
                    // Actualizar
                    await montoProvider.updateMonto(id!, nombre);
                    NotificationsService.showSnackbar('$nombre Actualizado!');
                  }

                  Navigator.of(context).pop();
                } catch (e) {
                  Navigator.of(context).pop();
                  NotificationsService.showSnackbarError(
                      'No se pudo guardar la categoría');
                }
              },
              text: 'Guardar',
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      color: Color(0xff0F2041),
      boxShadow: [BoxShadow(color: Colors.black26)]);
}
