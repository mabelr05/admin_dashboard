import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';


class PublicationsView extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text('Publications', style: CustomLabels.h1),

          SizedBox( height:10 ),

          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.horizontal,
            children:[

              WhiteCard(
                title: 'ac_unit_outlined',
                child: Center(child: Icon(Icons.ac_unit_outlined)),
                width: 170
              ),

              WhiteCard(
                title: 'ac_unit_outlined',
                child: Center(child: Icon(Icons.star_border_outlined)),
                width: 170
              ),

              WhiteCard(
                title: 'ac_unit_outlined',
                child: Center(child: Icon(Icons.linked_camera_outlined)),
                width: 170
              ),
           ],
         )
       ]
     )    
    );  
  }
}