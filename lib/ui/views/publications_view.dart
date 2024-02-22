import 'package:admin_dashboard/ui/modals/post_modal.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';

class PublicationsView extends StatelessWidget {
  const PublicationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Publicaciones', style: CustomLabels.h1),
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => const PostModal(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  //backgroundColor: Colors.teal, // Color del botón
                ),
                child: const Row(
                  children: [
                    Text('Crear Publicacion'),
                    Icon(Icons.add_outlined),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 100,
            margin: EdgeInsets.only(bottom: 10),
            //height: 500,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Column(
              children: [
                Text('Titulo'),
                Text('Descripcion'),
                //if (Image = !null) NetworkImage(url)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
