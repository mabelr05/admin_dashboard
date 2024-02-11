import 'package:admin_dashboard/models/categoria.dart';
import 'package:admin_dashboard/providers/categories_provider.dart';
import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriaModal extends StatefulWidget {

  final Categoria? categoria;

  const CategoriaModal({
    Key? key,
    this.categoria
  }) : super (key: key);

  @override
  _CategoriaModalState createState() =>  _CategoriaModalState();
}

class  _CategoriaModalState extends State<CategoriaModal> {

  String nombre = '';
  String? id;

  @override
  void initState(){
    super.initState();

    id = widget.categoria?.id;
    nombre = widget.categoria?.nombre ?? '';
  }

  @override
  Widget build(BuildContext context) {

    final categoryProvider = Provider.of<CategoriesProvider>(context, listen: false);

    return Container(
      padding: EdgeInsets.all(20),
      height: 500,
      width: 300, //expanded
      decoration: buildBoxDecoration(),
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.categoria?.nombre?? 'Nueva categoria', style: CustomLabels.h1.copyWith(color: Colors.white)),
              IconButton(
                icon: Icon( Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(context).pop()
                )
            ],
          ),
          Divider(color: Colors.white.withOpacity(0.3)),

          SizedBox(height: 20),

          TextFormField(
            initialValue: widget.categoria?.nombre?? '',
            onChanged: (value) => nombre = value,
            decoration: CustomInputs.loginInputDecoration(
              hint: 'Nombre de la Categoria', 
              label: 'Categoria', 
              icon: Icons.new_releases_outlined,
            ),
            style: TextStyle( color: Colors.white),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: CustomOutlinedButton(
              onPressed: () async {

                print(nombre);

                if ( id == null){
                  //crear
                  categoryProvider.newCategoria(nombre);
                }else{
                  //Actualizar
                }

                Navigator.of(context).pop();

              },
              text: 'Guardar',
              color: Colors.white,
              ),
          )
        ] ,
      ),
    );
  }    
      BoxDecoration buildBoxDecoration() => BoxDecoration(
        borderRadius: BorderRadius.only (topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Color(0xff0F2041),
        boxShadow: [
          BoxShadow(
          color: Colors.black26
      )
    ]
  );
}
