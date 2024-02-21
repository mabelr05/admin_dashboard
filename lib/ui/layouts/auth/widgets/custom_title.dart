import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({Key? key}) : super(key: key);

  @override
  Widget build (BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start ,
        children: [
          Image.asset(
            'admicon.png',
            width: 50,
            height: 50,
          ),

          const SizedBox( height: 20),

          FittedBox(
            fit:BoxFit.contain,
            child:Text(
            'Bienvenidos',
             style: GoogleFonts.montserratAlternates(
               fontSize: 60,
                color: const Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      ),
    );
  }
}