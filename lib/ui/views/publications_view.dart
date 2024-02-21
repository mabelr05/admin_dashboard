import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';


class PublicationsView extends StatelessWidget{
  const PublicationsView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Publications', style: CustomLabels.h1),

          const SizedBox( height:10 ),

          const Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.horizontal,
            children:[

              WhiteCard(
                title: 'ac_unit_outlined',
                width: 170,
                child: Center(child: Icon(Icons.ac_unit_outlined))
              ),

              WhiteCard(
                title: 'ac_unit_outlined',
                width: 170,
                child: Center(child: Icon(Icons.star_border_outlined))
              ),

              WhiteCard(
                title: 'ac_unit_outlined',
                width: 170,
                child: Center(child: Icon(Icons.linked_camera_outlined))
              ),
           ],
         )
       ]
     )    
    );  
  }
}