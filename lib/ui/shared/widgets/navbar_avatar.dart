import 'package:flutter/material.dart';

class NavbarAvatar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ClipOval( //Hace circular la imagen
      child: Container( 
          child: Image.network('https://lh3.googleusercontent.com/a/ACg8ocKAITG9xixErO9M_i8WCfTkGTAfdf18RR1UD4sKcA83cSk=s360-c-no'),
          width: 30,
          height: 30,
        ),
      );
  }
}