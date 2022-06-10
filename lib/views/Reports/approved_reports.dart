import 'package:flutter/material.dart';
import 'package:geoapp/views/Documents/approved_documents.dart';
import '../../constants/module.dart';
import 'package:flutter/cupertino.dart';
import '../../models/module.dart';
import '../module.dart';

class ApprovedReport extends StatefulWidget{
  ApprovedReport({Key? key,required this.approved_complaints}):super(key: key);
  List<Complaint> approved_complaints;

  @override
  ApprovedReportState createState()=> ApprovedReportState();
}

class ApprovedReportState extends State<ApprovedReport>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppConstants.primaryColor,
        title:const Text(''),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.10,
                color: AppConstants.primaryColor,
                child: const Center(
                  child: Text("Approved Reports",style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w800
                  ),),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.70,
              child: ListView.builder(
                  itemCount: widget.approved_complaints.length,
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>
                         ResultDocuments(url:
                         'https://php74.clifford.co.ke/geoinformant/public/files/'+'1653999192.pdf'
                         /*widget.approved_complaints.elementAt(index).file*/,
                         complaint: widget.approved_complaints.elementAt(index),
                         ),settings: const RouteSettings(
                           name: '/approveddocuments'
                         )));
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.10,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(1.0,1.0),
                                    blurRadius: 1.0,
                                    spreadRadius: 1.0,
                                    color: Colors.black12
                                )
                              ]
                          ),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:  [
                                         Padding(
                                          padding: EdgeInsets.only(bottom: 5.0),
                                          child: Text(
                                            'Report #' + widget.approved_complaints.elementAt(index)
                                                .complainee_id.toString(),
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(bottom: 0.0),
                                          child: Text('Approved',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: AppConstants.primaryColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold
                                            ),),
                                        ),

                                      ],
                                    ),
                                    IconButton(
                                      icon: const Icon(CupertinoIcons.forward,
                                        size: 40,color: Colors.green,),

                                      onPressed: (){

                                      },

                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}