import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/module.dart';
import 'package:provider/provider.dart';
import '../../models/module.dart';

class TextFieldContainer extends StatefulWidget{
  TextFieldContainer({Key? key,validator,@required controller,
    @required hintText,@required onChange,@required label_tag,minlines,suffixIcon,onTap,
    field_height,content_padding_width,content_padding_height,isEditable,
    field_width,textStyle,inputType,error_message
  }):super(key: key);
  late FormFieldValidator validator;
  late TextEditingController controller=TextEditingController();
  late String hintText;
  late Function(String) onChange;
  late String label_tag;
  late int minlines=1;
  late Icon suffixIcon;
  late Function onTap;
  late double field_height;
  late double field_width;
  late double content_padding_height;
  late double content_padding_width;
  late bool isEditable;
  late TextStyle textStyle;
  late TextInputType inputType;
  late String error_message='';

  @override
  TextFieldContainerState createState()=> TextFieldContainerState();
}

class TextFieldContainerState extends State<TextFieldContainer>{



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        color: Colors.transparent,
        elevation: 0,
        //width: MediaQuery.of(context).size.width,
        //height: MediaQuery.of(context).size.height * 0.10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(widget.label_tag,/*textScaleFactor:AppConstants.getScaleFactor(
                    Provider.of<Preferences>(context,listen: false).device_width)*/style: TextStyle(
                    fontSize: 14,fontWeight: FontWeight.w400,
                    fontFamily: GoogleFonts.inter().fontFamily,
                    color: checkIfNotEmpty() ? Colors.redAccent :Theme.of(context).accentColor
                ),),
              ),
              Container(
                width: widget.field_width,// ??MediaQuery.of(context).size.width,

                child: TextFormField(
                  controller: widget.controller,
                  validator: widget.validator,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.done,
                  minLines: widget.minlines,
                  enabled: widget.isEditable,// ?? true,

                  keyboardType: widget.inputType/*==null ? TextInputType.multiline: TextInputType.numberWithOptions(
                      signed: true
                  )*/,
                  onTap: (){
                    widget.onTap();
                  },

                  onChanged: (text){
                    widget.onChange(widget.controller.text);
                  },
                  decoration: InputDecoration(
                    hintText: widget.hintText,

                    suffixIcon: widget.suffixIcon,/*Icon(Icons.description,color: Colors.white,),*/
                    hintStyle: widget.textStyle /*TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 17 * AppConstants.getScaleFactor(
                          Provider.of<Preferences>(context,listen: false).device_width
                      ),
                      fontWeight: FontWeight.w500,
                    )*/,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                        BorderSide(color: checkIfNotEmpty() ? Colors.redAccent :Theme.of(context).primaryColor)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: checkIfNotEmpty() ? Colors.redAccent :
                        Theme.of(context).primaryColor)
                    ),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Theme.of(context).primaryColor)
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              )
            ],
          ),
        )
    );
  }

  bool checkIfNotEmpty(){
    if(widget.error_message!=null){
      if(widget.error_message.isNotEmpty){
        return true;
      }

      else{
        return false;
      }
    }
    else{
      return false;
    }
  }
}