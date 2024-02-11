import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    return Container(
      padding: EdgeInsets.only(top:30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Icono del admin
          Icon(Icons.account_circle, color: Color.fromARGB(255, 255, 255, 255)),
          SizedBox (width: 10),
          Text(
            'Admin',
            style: GoogleFonts.montserratAlternates(
              fontSize: 20,
              fontWeight: FontWeight.w200,
              color: Colors.white
            ),

          )
        ],
      ),
    );
  }
}