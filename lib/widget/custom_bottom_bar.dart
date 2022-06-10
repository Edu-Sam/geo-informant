import 'package:flutter/material.dart';
import 'module.dart';
import '../constants/module.dart';
import 'package:provider/provider.dart';
import '../models/module.dart';


class CustomBottomBar extends StatelessWidget{
  CustomBottomBar({Key? key,custom_bottom_bar_items,is_active}):super(key:key);
  late List<CustomBottomBarItem> custom_bottom_bar_items;
  late int is_active;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      height: (48 + MediaQuery.of(context).padding.bottom)/* * AppConstants.getScaleFactor(
          Provider.of<Preferences>(context,listen: false).device_width
      )*/,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        //  color: Colors.redAccent,
        border: Border(top: BorderSide(color: Theme.of(context).primaryColor)),

      ),

      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: custom_bottom_bar_items.asMap().map((i,element) =>
              MapEntry(i,CustomBottomBarItem(
                icon_description: element.icon_description,
                icon: element.icon,
                isActive: element.isActive,
                onTap: element.onTap,
                index: element.index,

              ))).values.toList()
      ),
    );
  }
}
