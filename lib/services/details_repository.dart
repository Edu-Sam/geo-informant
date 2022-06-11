import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geoapp/models/module.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';

class DetailsRepository{

  static const String BASE_URL=DomainServer.name;

  Future<dynamic> getDetails() async{
    String auth_username='clifford';
    String auth_password='g#hxnK3GGw&5';
    String basic_auth='Basic ' +  base64Encode(utf8.encode('$auth_username:$auth_password'));
    try{
      http.Response response=await http.get(Uri.parse(BASE_URL + 'host/api'),
          headers: {"Accept":"application/json","authorization": basic_auth},);

      var result=response.body;
      print("The response is " + result.toString());
      print("The response status code is " + response.statusCode.toString());
      return result.toString();
    }
    catch(Exception,stacktrace){
      print("Exception: " + stacktrace.toString());
    }
  }

  Future<dynamic> getLandLordDetails(int landlord_id) async{
    String auth_username='clifford';
    String auth_password='g#hxnK3GGw&5';
    String basic_auth='Basic ' +  base64Encode(utf8.encode('$auth_username:$auth_password'));
    try{

      http.Response response=await http.get(Uri.parse(BASE_URL + 'complaints/landlord/${landlord_id.toString()}',),
        headers: {"Accept":"application/json","authorization": basic_auth},);

      if(response.statusCode==200){
        var result=jsonDecode(response.body);
        log("The response1 is " + result.toString());
        var details_temp=result as List;
        List<Complaint> complaints= details_temp.map((e) => Complaint.fromJson(e)).toList();
        return complaints;
       // log("The response1 is " + result.toString());
      }

      else{
        return response.statusCode;
      }
    }
    catch(Exception,stacktrace){
       print("Exception: " + stacktrace.toString());
       return 500;
    }
  }

  Future<dynamic> getComplaintCategories() async{
    String auth_username='clifford';
    String auth_password='g#hxnK3GGw&5';
    String basic_auth='Basic ' +  base64Encode(utf8.encode('$auth_username:$auth_password'));
    try{
      http.Response response=await http.get(Uri.parse(BASE_URL + 'complaint_categories'),
        headers: {"Accept":"application/json","authorization": basic_auth},);

      var result=response.body;
      print('Response is ' + result.toString());
    }
    catch(Exception,stacktrace){
      print("Exception: " + stacktrace.toString());
      return 500;
    }
  }

  Future<dynamic> tenantComplaints(String tenant_national_id) async{
    String auth_username='clifford';
    String auth_password='g#hxnK3GGw&5';
    String basic_auth='Basic ' +  base64Encode(utf8.encode('$auth_username:$auth_password'));
    try{
      http.Response response=await http.get(Uri.parse(BASE_URL + 'complaints/tenant/${tenant_national_id}'),
        headers: {"Accept":"application/json","authorization": basic_auth},);

      print("The response status code is " + response.statusCode.toString());
      print("The response is " + response.body.toString());
      if(response.statusCode==200){
       // return response.statusCode;
        var result=jsonDecode(response.body);
        log("The response1 is " + result.toString());
        var details_temp=result as List;
        List<Complaint> complaints= details_temp.map((e) => Complaint.fromJson(e)).toList();
        return complaints.length;
      }

      else{
        return 0;
      }
    }
    catch(Exception,stacktrace){
      print("Error: " + stacktrace.toString());
      return 'Error Loading reports';
    }
  }

  Future<dynamic> insertComplaint(PlatformFile? objFile,
     int landlord_id,String name,String id_number,String description,
      String incident_date) async{
    String auth_username='clifford';
    String auth_password='g#hxnK3GGw&5';
    String basic_auth='Basic ' +  base64Encode(utf8.encode('$auth_username:$auth_password'));

    Map<String,String> headers={"Accept":"application/json","authorization": basic_auth};
    try{

      var response=http.MultipartRequest('POST',Uri.parse(BASE_URL + 'complaints/add'))
        ..headers.addAll(headers)
        ..fields['landlord_id']=landlord_id.toString()
        ..fields['name']=name
        ..fields['id_number']=id_number
        ..fields['description']=description
        ..fields['short_description']=''
        ..fields['complaint_category']=5.toString()
        ..fields['incident_date']=incident_date;



      /*response.files.add(http.MultipartFile('upload',File.fromUri(Uri.parse(objFile!.path ?? '')).readAsBytes().asStream(),
          await File.fromUri(Uri.parse(objFile.path ?? '')).length(),
          filename: objFile.name
      ));*/

      response.files.add(http.MultipartFile('doc',File.fromUri(Uri.parse(objFile!.path!)).readAsBytes().asStream(),
          await File.fromUri(Uri.parse(objFile.path!)).length(),
          filename: objFile.name
      ));


      http.StreamedResponse userResponse=await response.send();
      final res=await userResponse.stream.bytesToString();

      print("The complaint submit status code is " + userResponse.statusCode.toString());
      print("Complaint response: " + res);

      var result=res;
      return userResponse.statusCode;
    //  return result;
      /*var result=jsonDecode(res);

      if(result['response']=='1'){
        print('Result is ' + result['response']);
        int result1=int.parse(result['responseDetail']);
        return result1;
      }
      else{
        print('Result is ' + result['response']);
        return false;
      }*/
    }
    catch(Exception,ex){
      print('Error occured: ' + ex.toString());
      return false;
    }
  }
  

}