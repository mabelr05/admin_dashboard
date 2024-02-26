import 'package:flutter/material.dart';
import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:provider/provider.dart';
import '../../api/upload_file_api.dart';
import '../../providers/posts_provider.dart';
import '../../router/router.dart';
import '../../services/navigation_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import '../../api/config.dart';

class PostNewView extends StatefulWidget {
  const PostNewView({
    Key? key,
  }) : super(key: key);

  @override
  State<PostNewView> createState() => _PostNewViewState();
}

class _PostNewViewState extends State<PostNewView> {
  String img = ''; // Declarar img como variable global

  @override
  Widget build(BuildContext context) {
    PagueValue.img = '';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Crear Post', style: CustomLabels.h1),
          const SizedBox(height: 10),
          WhiteCard(
            child: Container(
              alignment: Alignment.center,
              height: 300,
              child: _NewPostViewBody(img: img), // Pasar img al constructor
            ),
          ),
        ],
      ),
    );
  }
}

class _NewPostViewBody extends StatelessWidget {
  final String img;

  const _NewPostViewBody({
    Key? key,
    required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        columnWidths: const {0: FixedColumnWidth(250)},
        children: [
          TableRow(children: [
            // AVATAR
            _PhotoContainer(),

            // Formulario de actualizacion
            _PostViewForm(img: img),
          ])
        ],
      ),
    );
  }
}

class _PostViewForm extends StatelessWidget {
  final String img;

  const _PostViewForm({
    Key? key,
    required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostsProvider>(context, listen: false);

    String titulo = '';
    String descripcion = '';
    String? id; // Define la variable id

    return WhiteCard(
      title: 'Contenido de la publicacion ',
      child: Column(
        children: [
          TextFormField(
            decoration: CustomInputs.formInputDecoration(
              hint: 'Titulo de la publicacion',
              label: 'Titulo',
              icon: Icons.supervised_user_circle_outlined,
            ),
            onChanged: (value) => titulo = value,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Ingrese un titulo';
              if (value.length < 3) {
                return 'El titulo debe de ser de tres letras como minimo';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: CustomInputs.formInputDecoration(
              hint: 'Que deseas Publicar?',
              label: 'Contenido',
              icon: Icons.email_outlined,
            ),
            onChanged: (value) => descripcion = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese una descripcion';
              }
              if (value.length < 10) {
                return 'La descripcion debe de ser de 10 letras como minimo';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 140),
            child: ElevatedButton(
              onPressed: () async {
                try {
                  // Crear
                  await postProvider.newPost(
                      titulo, descripcion, PagueValue.img);
                  print('Guardar Post --> ${PagueValue.img}');
                  NotificationsService.showSnackbar(
                      'Publicacion $titulo creado!');

                  //SideMenuProvider.closeMenu();

                  NavigationService.replaceTo(Flurorouter
                      .postsRoute); // Regresar a la pantalla anterior
                } catch (e) {
                  // Regresar a la pantalla anterior en caso de error
                  NotificationsService.showSnackbarError(
                      'No se pudo guardar la Publicación');
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 123, 141, 243)),
                shadowColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: const Row(
                children: [
                  Icon(Icons.save_outlined, size: 20),
                  Text(' Guardar', style: TextStyle(color: Colors.black))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _PhotoContainer extends StatefulWidget {
  @override
  _PhotoContainerState createState() => _PhotoContainerState();
}

class _PhotoContainerState extends State<_PhotoContainer> {
  @override
  Widget build(BuildContext context) {
    final image = (PagueValue.img.isNotEmpty)
        ? FadeInImage.assetNetwork(
            placeholder: 'loader.gif', image: PagueValue.img)
        : Image.asset('assets/no-image.jpg');

    return WhiteCard(
      width: 250,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Cargar Imagen', style: CustomLabels.h2),
            const SizedBox(height: 20),
            SizedBox(
              width: 150,
              height: 160,
              child: Stack(
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    width: 200,
                    height: 200,
                    child: image,
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.white, width: 5),
                      ),
                      child: FloatingActionButton(
                        backgroundColor:
                            const Color.fromARGB(255, 122, 138, 231),
                        elevation: 0,
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          size: 20,
                        ),
                        onPressed: () async {
                          // Código para seleccionar la imagen
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['jpg', 'jpeg', 'png'],
                            allowMultiple: false,
                          );

                          if (result != null) {
                            NotificationsService.showBusyIndicator(context);
                            String uploadedFileName =
                                await uploadFile(result.files.first.bytes!);
                            print(
                                'Nombre del archivo subido: $uploadedFileName');
                            setState(() {
                              PagueValue.img =
                                  '${AppConfig.urlServer}/uploads/imgs/$uploadedFileName';
                            });

                            Navigator.of(context).pop();
                          } else {
                            print('No hay imagen seleccionada');
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class PagueValue {
  static String img = '';
}
