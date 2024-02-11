import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoPageFoundView extends StatelessWidget{
  const NoPageFoundView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          '01 - Pagina no encontrada',
          style: GoogleFonts.montserratAlternates(
            fontSize: 50,
            fontWeight: FontWeight.bold
          ),
       ),
      ),
    );
  }
}



