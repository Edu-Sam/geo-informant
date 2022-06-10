import 'module.dart';
import 'package:flutter/foundation.dart';

class Preferences with  ChangeNotifier{
   User? user;
   int? id;
   int? user_id;
   bool? isLoggedIn;
   String user_state;
   String? token;

   Preferences({this.user,this.id,this.user_id,this.isLoggedIn,required this.user_state,
   this.token});


   Map<String,dynamic> toJson()=>{
      'user_id':user!.user_id,
      'isLoggedIn':isLoggedIn! ? 1 : 0,
      'user_state':user_state,
      'token':token.toString()
   };

   factory Preferences.fromDB(Map<String,dynamic> parsedJson){
      return Preferences(
         id: parsedJson['id'],
         user_id: parsedJson['user_id'],
         user_state: parsedJson['user_state'],
         isLoggedIn: parsedJson['isLoggedIn']==1 ? true : false
      );
   }

}