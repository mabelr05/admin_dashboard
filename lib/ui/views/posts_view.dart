import 'package:admin_dashboard/providers/posts_provider.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:provider/provider.dart';

import '../../services/date_convert.dart';
import '../../services/navigation_service.dart';

class PublicationsView extends StatefulWidget {
  const PublicationsView({Key? key}) : super(key: key);

  @override
  _PublicationsViewState createState() => _PublicationsViewState();
}

class _PublicationsViewState extends State<PublicationsView> {
  @override
  void initState() {
    super.initState();
    Provider.of<PostsProvider>(context, listen: false).getPosts();
  }

  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<PostsProvider>(context).posts;
    //print(posts);
    posts.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Publicaciones', style: CustomLabels.h1),
              ElevatedButton(
                onPressed: () {
                  NavigationService.replaceTo('/dashboard/new-post');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo, // Color del botón
                ),
                child: const Row(
                  children: [
                    Text(
                      'Crear Publicacion',
                      style: TextStyle(
                        color: Colors.white, // Color del texto del botón
                      ),
                    ),
                    Icon(
                      Icons.add_outlined,
                      color: Colors.white, // Color del ícono del botón
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (post.img != null)
                        Container(
                          width: 200,
                          height: 200,
                          margin: const EdgeInsets.only(right: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              post.img!,
                              width: 300, // Ancho deseado
                              fit: BoxFit
                                  .cover, // Ajustar cómo se muestra la imagen
                            ),
                          ),
                        ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.titulo,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              post.descripcion,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        child: Text(convertirFechaLegible(post.timeStamp),
                            style: const TextStyle(fontSize: 12)),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
