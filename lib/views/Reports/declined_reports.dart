import 'package:flutter/material.dart';
import '../../constants/module.dart';
import 'package:flutter/cupertino.dart';
import '../../models/module.dart';

class DeclinedReport extends StatefulWidget{
  DeclinedReport({Key? key,required this.declined_complaints}):super(key: key);
  List<Complaint> declined_complaints;

  @override
  DeclinedReportState createState()=> DeclinedReportState();
}

class DeclinedReportState extends State<DeclinedReport>{

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
                  child: Text("Declined Reports",style: TextStyle(
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
                  itemCount: widget.declined_complaints.length,
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){

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
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                                        const Padding(
                                          padding: EdgeInsets.only(bottom: 5.0),
                                          child: Text(
                                            'Declined Reports',
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 0.0),
                                          child: Text('Report #' + widget.declined_complaints.elementAt(index)
                                              .complainee_id.toString(),
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                                color: Colors.cyan,
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