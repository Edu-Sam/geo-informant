import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'dart:async';
import '../../services/module.dart';
import 'dart:io';
import '../../constants/module.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../../models/module.dart';
import 'package:provider/provider.dart';
import 'dart:convert';


class ApprovedDocuments extends StatefulWidget{
  ApprovedDocuments({Key? key,required this.url,required this.complaint}) : super(key: key);
  String url;
  Complaint? complaint;


  @override
  _ApprovedDocumentState createState()=> _ApprovedDocumentState();
}

class _ApprovedDocumentState extends State<ApprovedDocuments>{

  late Future<PDFDocument> future_file;
  String pdfPath='';
  ReportsRepository reportsRepository=ReportsRepository();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  String? path;
   Future<void>? future_path;
  // future_path=setPath();
  final Completer<PDFViewController> _controller= Completer<PDFViewController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("The url is " + widget.url.toString());

    //future_file=this.getDocument();
    future_path=setPath();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     return Scaffold(
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
             children: [
               /*Padding(
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
               ),*/
               Container(
                 width: MediaQuery.of(context).size.width,
                 height: MediaQuery.of(context).size.height,
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
               ),


               /*Container(
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
               )*/
             ],
           ),
         )
       ),
         floatingActionButton: FutureBuilder<PDFViewController>(
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
         ),
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
    /*return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,color: Colors.grey,size: 20,),
          onPressed: (){

          },
        ),),

      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column()
      ),
    );
  }*/


}