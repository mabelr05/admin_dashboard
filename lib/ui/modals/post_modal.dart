import 'package:admin_dashboard/providers/categories_provider.dart';
import 'package:admin_dashboard/providers/posts_provider.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostModal extends StatefulWidget {
  const PostModal({
    Key? key,
  }) : super(key: key);

  @override
  PostModalState createState() => PostModalState();
}

class PostModalState extends State<PostModal> {
  String titulo = '';
  String descripcion = '';
  String? id;

  @override
  Widget build(BuildContext context) {
    final postProvider =
        Provider.of<PostsProvider>(context, listen: false);

    // Get screen width
    final screenWidth = MediaQuery.of(context).size.width;

    return Expanded(
      //padding: const EdgeInsets.all(20),
      //height: 700,
      //width: screenWidth * 0.8, // Set width to 80% of screen width
      //decoration: buildBoxDecoration(),
      child: Container(decoration: buildBoxDecoration(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Nueva Publicación',
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
            Column(
              children: [
                Image.asset(
                  'assets/no-image.jpg',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 20), // Add spacing between image and text fields
                TextFormField(
                  onChanged: (value) => titulo = value,
                  decoration: CustomInputs.formInputDecoration(
                      hint: 'Titulo del Post',
                      label: 'Titulo',
                      icon: Icons.new_releases_outlined),
                  style: const TextStyle(color: Colors.white),
                ),
                TextFormField(
                  onChanged: (value) => descripcion = value,
                  decoration: CustomInputs.formInputDecoration(
                      hint: 'Descripción del Post',
                      label: 'Descripción',
                      icon: Icons.new_releases_outlined),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 20), // Add spacing between text fields and button
            Container(
              alignment: Alignment.center,
              child: CustomOutlinedButton(
                onPressed: () async {
                  try {
                    if (id == null) {
                      // Crear
                      await postProvider.newPost(titulo, descripcion,null);
                      NotificationsService.showSnackbar('$titulo creado!');
                    } else {
                      // Actualizar
                      await postProvider.updatePost(id!, titulo);
                      NotificationsService.showSnackbar('$titulo Actualizado!');
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
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      color: Color(0xff0F2041),
      boxShadow: [BoxShadow(color: Colors.black26)]);
}
