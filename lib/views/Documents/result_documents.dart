import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:geoapp/views/Documents/approved_documents.dart';
import 'dart:async';
import '../../services/module.dart';
import 'dart:io';
import '../../constants/module.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../../models/module.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:ext_storage/ext_storage.dart';
import 'package:external_path/external_path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'dart:isolate';
import 'dart:ui';

import 'package:path_provider_android/path_provider_android.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';


class ResultDocuments extends StatefulWidget{
  ResultDocuments({Key? key,required this.url,required this.complaint}) : super(key: key);
  String url;
  Complaint? complaint;


  @override
  _ResultDocumentState createState()=> _ResultDocumentState();
}

class _ResultDocumentState extends State<ResultDocuments>{

  late Future<PDFDocument> future_file;
  String pdfPath='';
  ReportsRepository reportsRepository=ReportsRepository();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  String? path;
  Future<void>? future_path;
  bool storage_permission=false;
  static var httpClient = new HttpClient();
  final bool debug = true;
  // future_path=setPath();
  final Completer<PDFViewController> _controller= Completer<PDFViewController>();
  bool isLoading=false;




 // List<_TaskInfo>? _tasks;
 // late List<_ItemHolder> _items;
  late bool _isLoading;
  late bool _permissionReady;
  late String _localPath;
  ReceivePort _port = ReceivePort();


  @override
  void initState() {
    // TODO: implement initState
    initializeDownloader();
    super.initState();

    print("The url is " + widget.url.toString());
     checkStoragePermission();

    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState((){ });
    });

    FlutterDownloader.registerCallback(downloadCallback);
    future_path=setPath();

  }

  _downloadListener() {
    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String? id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      if (status.toString() == "DownloadTaskStatus(3)" && progress == 100 && id != null) {
        String query = "SELECT * FROM task WHERE task_id='" + id + "'";
        var tasks = FlutterDownloader.loadTasksWithRawQuery(query: query);
        //if the task exists, open it
        if (tasks != null) FlutterDownloader.open(taskId: id);
      }
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  /*static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }*/

  @pragma('vm:entry-point')
  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading:IconButton(
              icon: Icon(Icons.arrow_back_ios,color: Colors.green.shade800,),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),
          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Submitted',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,
                              fontSize: 14),),
                          Text(widget.complaint!.created_at.substring(0,10))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Tenant',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,
                              fontSize: 14),),
                          Text(widget.complaint!.complainee_name)
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('ID',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,
                              fontSize: 14),),
                          Text(widget.complaint!.complainee_id.toString())

                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.40,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                        child: Column(
                          children: [
                            Text(
                              widget.complaint!.long_description,
                              style: const TextStyle(
                                  fontSize: 12,fontWeight: FontWeight.w500,
                                  color: Colors.black54
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    Padding(

                        padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 20.0),
                        child:   GestureDetector(
                          onTap: () async{
                            setState(() {
                              isLoading=true;
                            });


                            await _requestDownload().then((value){
                              setState(() {
                                isLoading=false;
                              });
                            });
                            /*await _downloadFile(widget.url, widget.complaint!.file).then((value){
                              setState(() {
                                isLoading=false;
                              });
                            });*/
                            /*Navigator.push(context, MaterialPageRoute(builder: (context)
                            => ApprovedDocuments(url: widget.url, complaint: widget.complaint)));*/
                          },
                          child:  const Text('View Document',style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),),
                        )
                    ),
                    /*Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.60,
                  child: FutureBuilder<void>(
                    future: future_path,
                    builder: (context,snapshot){
                      if(snapshot.connectionState==ConnectionState.done){
                        //PDFDocument document=snapshot.data!;
                        /* return Container();*/
                        return Stack(
                          children: <Widget>[
                            PDFView(
                              filePath: path,
                              enableSwipe: true,
                              swipeHorizontal: true,
                              autoSpacing: false,
                              pageFling: true,
                              pageSnap: true,
                              defaultPage: currentPage!,
                              fitPolicy: FitPolicy.BOTH,
                              preventLinkNavigation:
                              false, // if set to true the link is handled in flutter
                              onRender: (_pages) {
                                setState(() {
                                  pages = _pages;
                                  isReady = true;
                                });
                              },
                              onError: (error) {
                                setState(() {
                                  errorMessage = error.toString();
                                });
                                print(error.toString());
                              },
                              onPageError: (page, error) {
                                setState(() {
                                  errorMessage = '$page: ${error.toString()}';
                                });
                                print('$page: ${error.toString()}');
                              },
                              onViewCreated: (PDFViewController pdfViewController) {
                                _controller.complete(pdfViewController);
                              },
                              onLinkHandler: (String? uri) {
                                print('goto uri: $uri');
                              },
                              onPageChanged: (int? page, int? total) {
                                //    print('page change: $page/$total');
                                setState(() {
                                  currentPage = page;
                                });
                              },
                            ),

                          ],
                        );
                        /*return Container(
                 width: MediaQuery.of(context).size.width,
                 height: MediaQuery.of(context).size.height,
                 color: Colors.white,
                 child: PDFViewer(
                   document: document,
                   zoomSteps: 8,
                   maxScale: 3.0,
                   minScale: 2.0,
                   enableSwipeNavigation: true,
                   panLimit: 30,
                 ),
               );*/

                      }

                      else if(snapshot.hasError){
                        print('error: ' + snapshot.error.toString());
                        return Container();
                      }

                      else{
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(AppConstants.thirdColor),
                          ),
                        );
                      }
                    },
                  ),
                ),*/


                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.10,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0,horizontal: 20.0
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(widget.complaint!.status,style: const TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,
                                      fontSize: 14),),
                                  Text(widget.complaint!.status_update_date,)
                                ],
                              )
                            ],
                          ),
                        )
                    )
                  ],
                ),
              )
          ),
          /* floatingActionButton: FutureBuilder<PDFViewController>(
           future: _controller.future,
           builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
             if (snapshot.hasData) {
               return FloatingActionButton.extended(
                 label: Text("Go to ${pages! ~/ 2}"),
                 onPressed: () async {
                   await snapshot.data!.setPage(pages! ~/ 2);
                 },
               );
             }

             return Container();
           },
         ),*/
        ),
        isLoading ?
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black.withOpacity(0.4),
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppConstants.primaryColor),
            ),
          ),
        ) :
        Container()
      ],
    );
  }

  Future<PDFDocument> getDocument() async{
    String auth_username='clifford';
    String auth_password='g#hxnK3GGw&5';
    String basic_auth='Basic ' + base64Encode(utf8.encode('$auth_username:$auth_password'));
    PDFDocument document=await PDFDocument.fromURL("https://extension.tennessee.edu/publications/documents/sp732.pdf"/*widget.url,headers:{"Accept":"application/pdf","authorization": basic_auth},*/)
        .then((value){
      // print("response: " + value.toString());
      return value;
    });
    return document;
  }

  Future<void> setPath() async{
    var result=await reportsRepository.getApprovedDocument(widget.url/*'https://extension.tennessee.edu/publications/documents/sp732.pdf'*/);
    if(result is File){
      setState(() {
        path=result.path;
      });
    }
    /*else{
      setState(() {
        errorMessage='Please connect to the internet';
      });
    }*/
  }

  Future<File?> _downloadFile(String url,String filename) async {
    if(storage_permission){
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      /*  String dir;
     Directory express_Dir=new Directory('Shopilyv-Express');
     await express_Dir.create().then((value){
       dir=express_Dir.path;
     });
*/
      var bytes = await consolidateHttpClientResponseBytes(response);
      // Uint8List bytes = base64.decode(url);
      String dir= await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
      //   var dir=(await _platform.getDownloadsPath());
      //    String dir = (await getApplicationDocumentsDirectory()).path;
      File file = new File('$dir/$filename');
      await file.writeAsBytes(bytes);
      print('Completed');

      // Uint8List bytes1=bytes;
      //final result = await ImageGallerySaver.saveImage(bytes);
      //print(result);


      return file;
    }

    else{
      print('No permissions granted');
      return null;
    }
  }

  Future<bool> checkStoragePermission() async{
    var status = await Permission.storage.request();
    if (status.isGranted) {
      storage_permission=true;
      return true;
    }

// You can can also directly ask the permission about its status.
    else if(status.isDenied) {
      storage_permission=false;
      return false;
      // The OS restricts access, for example because of parental controls.
    }

    else{
      storage_permission=false;
      return false;
    }
  }

  Future<void> _requestDownload() async {
    String auth_username='clifford';
    String auth_password='g#hxnK3GGw&5';
    String basic_auth='Basic ' +  base64Encode(utf8.encode('$auth_username:$auth_password'));


    String? id = await FlutterDownloader.enqueue(
      url: 'https://www.orimi.com/pdf-test.pdf'
      //url: 'https:be-express.org/beexpress/images/image_picker1109783911598712200.jpg',
   //   url: 'https:be-express.org/beexpress/images/passport.pdf',
     // url: widget.url,
    //  headers: {"auth": "test_for_sql_encoding"},
      headers: {/*"Accept":"application/json",*/"authorization": basic_auth},
      savedDir: await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS),
      showNotification: true,
      openFileFromNotification: true,
      saveInPublicStorage: true,
    );
  }

  Future<void> initializeDownloader() async{
   // WidgetsFlutterBinding.ensureInitialized();
    await FlutterDownloader.initialize();
   // WidgetsFlutterBinding.ensureInitialized();
   // await FlutterDownloader.initialize(debug: debug, ignoreSsl: true);
  }


}
