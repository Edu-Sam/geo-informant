import 'package:flutter/material.dart';
import '../../widget/module.dart';
import 'package:provider/provider.dart';
import 'module.dart';
class Validation{

  String field_tag='',special_tag='',password_length_tag='';
  //ErrorContainer errorContainer=ErrorContainer();




  String? emailValidator(String value,BuildContext context) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex =  RegExp(pattern);
    if (!regex.hasMatch(value)) {

    //  return '';
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String? wordsValidator(String value,BuildContext context){
    if(value.isEmpty){
      return 'Field is Required';
    }

    else{
      return null;
    }
  }

  String? nameValidator(String value,BuildContext context){
    //setWords(context);
    String value1=value.trimRight();
    if(value.length > 0){
      Pattern letter=r'[a-zA-Z]{3}$';
      Pattern digit="0-9";
      Pattern special="(?=.*?[!@#\$&*~])";
      String pattern=r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-.,/%]$';



      RegExp regex=RegExp(pattern);
      if(value1.isEmpty){
        return 'Field is required';
       // return field_tag;
      }
      else{
        if(regex.hasMatch(value1)){
         // return special_tag;
            return 'No special characters allowed in field';
        }
        else{
          return null;
        }
      }


    }
    else{
        return 'Field is required';
    //  return field_tag;
    }

  }
  /*String pwdValidator(String value,BuildContext context) {
    /*  if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }*/
    if(value.length > 5){
      Pattern letter='r[a-zA-z]{5,}';
      Pattern digit="0-9";
      Pattern special="(?=.*?[!@#\$&*~,.\" ])";
      Pattern special1='[\W]';
      Pattern pattern= r'(?=.*?[a-zA-z]).{5,}(?=.*?[0-9])(?=.*?[!@#\$&*~.])';
      //  Pattern pattern1= r'(?:(?=.*?[a-zA-z]).{5,}(?=.*?[0-9])(?=.*?[!@#\$&*~.])| (?=.*?[0-9])(?=.*?[!@#\$&*~.])(?=.*?[a-zA-z]).{5,})$';
      Pattern pattern1=r'^(?:(?=.*[a-zA-z]).{5,}|(?=.*[\d\W])|(?=.*\W])(?=.*\d)(?:(?=.*[a-zA-z]).{5,}(?=.*[\d])(?=.*[\W])|(?=.*\W)(?=.*\d)(?=.*[a-zA-z]).{5,})|(?=.*\W)(?=.*[a-zA-z]).{5,}(?=.*\d))$';
//(?=.*[\d\W])
      RegExp regSpecial=new RegExp(special);
      RegExp regex=new RegExp(pattern1);
      if(value.isEmpty){
        return 'Please Enter password';
      }
      else{
        if(!regex.hasMatch(value)){
          return 'Invalid password.Password must include a symbol or a number and have atleast 5 characters';
        }
        else{
          return null;
        }
      }
    }
    else{
      return 'password must be longer than 8 characters';
    }
  }*/

  String? pwdValidator(String value,BuildContext context) {
    if (value.length < 8) {
        return 'Password must be longer than 8 characters';
     // return password_length_tag;
    } else {
      return null;
    }

  }


  String? phoneValidator(String value,BuildContext context){
    String new_value;
    /* if(value.length < 10){
      return "Please enter a valid phone number";
    }
    else{
      if(( value.startsWith("07")) && value.length==10){
        }
      else if((value.startsWith("+254")) && value.length==13){
      }
      else{
        return "Invalid phone number format";
      }
    }*/

    // String pattern=r'(^(?:[+0]7)?[0-9]{10,13}$)';
    //  |(^(?:[+]2547)?[0-9]{10,13}$)
    //  Pattern pattern=r'(^(?:[+0]7)?[0-9]{10,13}$)';
    // Pattern pattern=r'(^(?:[0]7)?[0-9]{10,13}$)';
    //  Pattern pattern='^(0|+[0-9]{1,3})?([7-9][0-9]{9,15})';
    String pattern=r'^[0-9]+$';

    if(( value.startsWith("07")) && value.length==10){
      new_value=value.substring(2,10);

    }
    else if((value.startsWith("+254")) && value.length==13){
      new_value=value.substring(4,13);
    }

    else{
      return 'Please enter a valid phone number';
    }

    RegExp regExp=RegExp(pattern);
    if(value.isEmpty){
      return 'Mobile number is empty';
    }
    else if(!regExp.hasMatch(new_value)){
      return 'please enter valid mobile number';
    }

    return null;

  }


  String? nationalIdNumber(String value,BuildContext context){
    String pattern=r'^[0-9]+$';


    RegExp regExp=RegExp(pattern);
    if(value.length==0){
      return 'National ID number is empty';
    }
    else if(!regExp.hasMatch(value)){
      return 'please enter valid national ID number';
    }

    return null;
  }
  String? bankAccountValidator(String value,BuildContext context){
    if(value.length > 7){
      String pattern=r'^(?=.*?[0-9])';

      RegExp regex=RegExp(pattern);

      if(value.isEmpty){
        return 'Please enter bank account';
      }

      else if(!regex.hasMatch(value)){
        return 'Enter valid bank account';
      }

      else{
        return null;
      }
    }

    else{
      return 'Account Number must be atleast 8 characters';
    }
  }


  String? businessNoValidator(String value,BuildContext context){
    if(value.length > 5){
      // Pattern pattern=r'^(?=.*?[0-9])*$';
      String pattern=r'^(?=.*?[0-9])';

      RegExp regex=RegExp(pattern);

      if(value.isEmpty){
        return 'Please enter business number';
      }

      else if(!regex.hasMatch(value)){
        return 'Enter valid business number';
      }

      else{
        return null;
      }
    }

    else{
      return 'Business Number must be atleast 6 characters';
    }
  }

  String? checkDate(String value,BuildContext context){
    if(value.isEmpty){
      return 'Select appropriate date';
    }
    return null;
  }

  String? checkTime(String value,BuildContext context){
    if(value.isEmpty){
      return 'Select appropriate time';
    }
    return null;
  }

  String concatenateNumber(String code,String number){

    if(number.startsWith("0")){
      String new_value=number.substring(1,number.length);
      String new_value1=code+new_value;
      return new_value1;
    }

    else{
      String new_value=code + number;
      return new_value;
    }



  }

  /*setWords(BuildContext context){
    field_tag=Provider.of<Preferences>(context,listen: false).dictionary_list.firstWhere((element) =>
    element?.code==750)?.word;
    special_tag=Provider.of<Preferences>(context,listen: false).dictionary_list.firstWhere((element) =>
    element.code==751)?.word;
    password_length_tag=Provider.of<Preferences>(context,listen: false).dictionary_list.firstWhere((element) =>
    element.code==88)?.word;
  }*/


}