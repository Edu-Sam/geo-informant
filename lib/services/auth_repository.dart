import 'package:flutter/material.dart';
import 'package:geoapp/auth/database-service.dart';
import '../models/module.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository{


  static const String BASE_URL=DomainServer.name;
  DatabaseService databaseService=DatabaseService();
  Future<SharedPreferences> _prefs=SharedPreferences.getInstance();
  late SharedPreferences pref;


  Future<dynamic> signIn(String email,String password,Preferences preferences,String user_type) async{
    String auth_username='clifford';
    String auth_password='g#hxnK3GGw&5';
    String basic_auth='Basic ' +  base64Encode(utf8.encode('$auth_username:$auth_password'));
    print("The deployed user type is " + user_type.toString());
    try{
        http.Response response=await http.post(Uri.parse(BASE_URL + 'login'),
        headers: {"Accept":"application/json","authorization": basic_auth},
        body: {
         'email':email,
          'password':password,
          'api':'1'});

       // var result=jsonDecode(response.body);
     //   var result=response.body;
        print("signed in Response is " + response.body.toString());
        if(response.statusCode==200){
          var result=jsonDecode(response.body);
          User user=User.fromJson(result['user']);
          if(user_type==user.user_type){
            var db_result=await databaseService.deleteAccount().then((accountDeleted) async{
              int? delete_user=await databaseService.deleteUser().then((userDeleted) async{
                int? insertUser=await databaseService.insertUser(user).then((userInserted) async{
                  User? databaseUser=await databaseService.getUser();
                  if(databaseUser is User){
                    preferences.isLoggedIn=true;
                    preferences.user=databaseUser;
                    preferences.user_state='LOGGED_IN';
                    preferences.token=result['token'];
                    preferences.user_id=databaseUser.user_id;
                    print("User token is " + preferences.token.toString());

                    int insertPreferences=await databaseService.insertPreference(preferences);
                    setSignUpPreferences('LOGGED_IN');
                    return insertPreferences;
                  }
                });

                return insertUser;
              });
              return delete_user;
            });
          }

          else{
            return 'Authentication Error.Please try again';
          }
          return preferences;
        }

        else{
         // return 1;
          var result=jsonDecode(response.body);
          return result['error'];
        }


    }
    catch(Exception,stacktrace){
      print("Error: " + stacktrace.toString());
      return 'Error occured.Please try again';
    }
  }

  Future<dynamic> signup(User user) async{
    String auth_username='clifford';
    String auth_password='g#hxnK3GGw&5';
    String basic_auth='Basic ' +  base64Encode(utf8.encode('$auth_username:$auth_password'));
    try{
      http.Response response=await http.post(Uri.parse(BASE_URL + 'register'),
          headers: {"Accept":"application/json","authorization": basic_auth},
          body: {
            'name2':user.name,
            'email2':user.email,
            'user_type2':user.user_type.toString(),
            'password2':user.password,
            'password2_confirmation': user.password,
            'api':'5'
          //  'mobile':user.mobile
          }
      );

      print("the signup response is " + response.body.toString());
      print("Status code is " + response.statusCode.toString());
      if(response.statusCode==200){
       // var result=jsonDecode(response.body);
        return '';
      }

      else if(response.statusCode==401){
        var result=jsonDecode(response.body);
        return result['error'];
      }

      else{
        return 'Error Occurred.Please try again';
      }
    }
    catch(Exception,stacktrace){
      print("Error: " + stacktrace.toString());
      return 500;
    }
  }

  Future<dynamic> verifyOTP(String otp,String email,Preferences preferences) async{
    String auth_username='clifford';
    String auth_password='g#hxnK3GGw&5';
    String basic_auth='Basic ' +  base64Encode(utf8.encode('$auth_username:$auth_password'));
    try{
        http.Response response=await http.post(Uri.parse(BASE_URL + 'otp_verify'),
          headers: {"Accept":"application/json","authorization": basic_auth},
          body: {
          'otp':otp.toString(),
          'email':email.toString()});

        print('otp response is ' + response.body.toString());
        if(response.statusCode==200){
          var result=jsonDecode(response.body);
          User user=User.fromJson(result['user']);
          var db_result=await databaseService.deleteAccount().then((accountDeleted) async{
            int? delete_user=await databaseService.deleteUser().then((userDeleted) async{
              int? insertUser=await databaseService.insertUser(user).then((userInserted) async{
                User? databaseUser=await databaseService.getUser();
                if(databaseUser is User){
                  preferences.isLoggedIn=true;
                  preferences.user=databaseUser;
                  preferences.user_state='LOGGED_IN';
                  preferences.token=result['token'];
                  preferences.user_id=databaseUser.user_id;
                  print("User token is " + preferences.token.toString());

                  int insertPreferences=await databaseService.insertPreference(preferences);
                  setSignUpPreferences('LOGGED_IN');
                  return insertPreferences;
                }
              });

              return insertUser;
            });
            return delete_user;
          });
          return preferences;
        }

        else{
          var result=jsonDecode(response.body);
          return result['error'];
          //return response.statusCode;
        }


    }
    catch(Exception,stacktrace){
      print("Error: " + stacktrace.toString());
      return 'Error Occurred.Please try again';
    }
  }

  Future<void> setSignUpPreferences(String state) async{
    pref=await _prefs;
    if(pref.containsKey('user_state')){
      pref.remove('user_state');
      pref.setString('user_state', state);
      //print('The state a is ' + pref.getString('user_state'));
    }

    else{
      pref.setString('user_state', state);
    //  print('The state b is ' + pref.getString('user_state'));
    }
  }
}