import 'package:flutter/material.dart';
import 'package:admin_dashboard/ui/buttons/link_text.dart';

class LinksBar extends StatelessWidget{
  const LinksBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      color: Colors.black,
     height: (size.width>1000)? size.height * 0.07:null,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          // ignore: avoid_print
          LinkText( text: 'Co-Gobierno Estudiantil ISTL', onPressed: () => print('https://www.facebook.com/profile.php?id=100090590160198')),
        ],
      )
    );
  }

  
}