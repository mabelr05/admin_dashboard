import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';


class BlankView extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Blank View', style: CustomLabels.h1),

          const SizedBox(height:10),

          const WhiteCard(
            title: 'Blank Page',
            child: const Text ('Hola Mundo')
          )
          
        ],
      ), 
    );
  }
}