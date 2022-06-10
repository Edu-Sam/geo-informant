import 'package:flutter/material.dart';
import '../constants/module.dart';
import '../models/module.dart';
import 'package:provider/provider.dart';

class CustomBottomBarItem extends StatelessWidget{
  CustomBottomBarItem({Key? key,@required icon_description,@required icon,
    isActive,index,onTap});
  late Function onTap;
  late Icon icon;
  late String icon_description;
  late int isActive=0;
  late int index;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: (){
          onTap();
        },
        child: Padding(
          padding: EdgeInsets.only(
              left: 1.0
          ),
          child: Container(
            color: Colors.grey.shade50,
            width: MediaQuery.of(context).size.width,
            height:  (48)/* * AppConstants.getScaleFactor(
                Provider.of<Preferences>(context,listen: false).device_width
            )*/,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 0.0),
                  child: icon,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}