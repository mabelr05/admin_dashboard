import 'dart:js' as js;
import 'package:admin_dashboard/providers/pago_provider.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/ui/app_colors.dart';
import 'package:admin_dashboard/ui/buttons/custom_icon_button.dart';
import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/pago.dart';

class PagoModal extends StatefulWidget {
  final Pago? pago;

  const PagoModal.PagoModal({Key? key, this.pago}) : super(key: key);

  @override
  PagoModalState createState() => PagoModalState();
}

class PagoModalState extends State<PagoModal> {
  String status = '';
  String? id;

  @override
  void initState() {
    super.initState();

    id = widget.pago?.id;
    status = widget.pago?.status ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final pagoProvider = Provider.of<PagosProvider>(context, listen: false);

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
              Text(widget.pago?.nombreEstudiante ?? 'Nuevo Pago',
                  style: CustomLabels.h1.copyWith(color: AppColor.kPrimary)),
              IconButton(
                  icon: Icon(
                    Icons.close,
                    color: AppColor.kPrimary,
                  ),
                  onPressed: () => Navigator.of(context).pop())
            ],
          ),
          Divider(color: AppColor.kPrimary.withOpacity(0.3)),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            value: status,
            onChanged: (newValue) {
              setState(() {
                status = newValue!;
              });
            },
            items: ['Pendiente', 'Aprobado', 'Rechazado'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            decoration: CustomInputs.loginInputDecoration(
                hint: 'Seleccione un estado',
                label: 'Estado',
                icon: Icons.new_releases_outlined),
            style: TextStyle(color: AppColor.kPrimary),
          ),
          // TextFormField(
          //   initialValue: widget.pago?.status ?? '',
          //   onChanged: (value) => status = value,
          //   decoration: CustomInputs.loginInputDecoration(
          //       hint: 'Nombre de la categoría',
          //       label: 'Status',
          //       icon: Icons.new_releases_outlined),
          //   style: const TextStyle(color: Colors.white),
          // ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: CustomOutlinedButton(
              onPressed: () async {
                try {
                  if (id == null) {
                    // Crear
                    //await pagoProvider.newPago(nombre);
                    NotificationsService.showSnackbar('$status creado!');
                  } else {
                    // Actualizar
                    await pagoProvider.updatePago(id!, status, null);
                    NotificationsService.showSnackbar('$status Actualizado!');
                  }

                  Navigator.of(context).pop();
                } catch (e) {
                  Navigator.of(context).pop();
                  NotificationsService.showSnackbarError(
                      'No se pudo guardar la categoría');
                }
              },
              text: 'Guardar',
              color: AppColor.kPrimary,
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              child: CustomIconButton(
                  onPressed: () {
                    String comprobanteUrl = widget.pago!.comprobante;

                    // Abrir una nueva pestaña en el navegador con la URL del comprobante
                    js.context.callMethod('open', [comprobanteUrl, '_blank']);
                  },
                  text: 'Ver Comprobante',
                  icon: Icons.photo_album_outlined))
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      color: Colors.white,
      boxShadow: [BoxShadow(color: Colors.black26)]);
}
