import 'package:flutter/material.dart';

class BackgroundAdmicon extends StatelessWidget {
  const BackgroundAdmicon({Key? key}) : super(key: key);


@override
Widget build (BuildContext context) {
  return Expanded(
          child: Container(
          decoration: buildBoxDecoration(),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: const Center(
              child:Padding(
              padding: EdgeInsets.symmetric(horizontal:30),
              child: Image(
                image: AssetImage('admicon.png'),
                width: 800,
              ),
            ),
          ),
        ),
      )
    );
  }
 BoxDecoration buildBoxDecoration() {
  return const BoxDecoration(
    
  );
 }
}