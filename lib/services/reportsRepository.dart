import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

class ReportsRepository{

  Future<dynamic> getApprovedDocument(String url) async{
    Completer<File> completer= Completer();
    String auth_username='clifford';
    String auth_password='g#hxnK3GGw&5';
    String basic_auth='Basic ' + base64Encode(utf8.encode('$auth_username:$auth_password'));
    Map<String,String> headers={"Accept":"application/json","authorization": basic_auth};
    try{
      //   final url='https://www.gstatic.com/policies/privacy/pdf/20210701/7yn50xee/google_privacy_policy_en-GB.pdf';
      // final url='https://amaizi-staging.herokuapp.com/v1/acp/document/cdn/61faad7ac3de96001627a29b';
    //  final url='https://www.amaiziapp.com/document/en/?doc=privacypolicy';
      final filename=url.substring(url.lastIndexOf("/") + 1);
      var request=await HttpClient().getUrl(Uri.parse(url))..headers.add('Accept', 'application/json')
      ..headers.add("authorization", basic_auth);
      var response=await request.close();
      var bytes=await consolidateHttpClientResponseBytes(response);
      var dir=await getApplicationDocumentsDirectory();
      File file=File("${dir.path}/$filename");

      await file.writeAsBytes(bytes,flush: true);
      completer.complete(file);

    }

    on SocketException catch(_){
      return 500;
    }

    on IOException catch(_){
      return 503;
    }

    return completer.future;
  }
}