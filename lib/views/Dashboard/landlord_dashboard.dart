import 'package:flutter/material.dart';
import 'package:geoapp/models/module.dart';
import 'package:geoapp/constants/module.dart';
import 'package:flutter/cupertino.dart';
import 'package:geoapp/views/module.dart';
import 'package:geoapp/services/module.dart';
import 'package:provider/provider.dart';
import 'package:external_path/external_path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class LandlordDashboard extends StatefulWidget{
  LandlordDashboard({Key? key}):super(key: key);

  @override
  LandlordDashboardState createState()=> LandlordDashboardState();
}

class LandlordDashboardState extends State<LandlordDashboard>{

  DetailsRepository detailsRepository=DetailsRepository();
  late Future<dynamic> future_detail;
  Future<dynamic>? future_landlord;
  late Future<dynamic> future_complaint_categories;
  bool storage_permission=false;
  static var httpClient = new HttpClient();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // future_detail=getDetails();
    future_landlord=getLandlordDetails();
    checkStoragePermission();
   // future_complaint_categories=getComplaintCategories();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        /*leading: IconButton(icon: const Icon(Icons.arrow_back_ios,size: 20,
        color: Colors.black54,),onPressed: (){
          Navigator.pop(context);
        },),*/
      ),

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: FutureBuilder<dynamic>(
          future: future_landlord,
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
              if(snapshot.data is List<Complaint>){
                List<Complaint> complaints=snapshot.data;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Hello " + Provider.of<Preferences>(context,listen: false).user!.name.split(' ')
                              .first,style: TextStyle(
                              //  color: AppConstants.primaryColor,
                                color: AppConstants.primaryColor,
                                fontSize: 35,
                                fontWeight: FontWeight.w900
                            ),),

                            IconButton(
                              icon: const Icon(
                                CupertinoIcons.gear_big,
                                color: Colors.grey,
                                size: 30,

                              ),
                              onPressed: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context)
                                 => MyProfile(),settings: RouteSettings(
                                   name: '/myprofile'
                                 )));
                              },
                            )
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.70,
                          child: ListView(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                      SubmittedReport(submitted_complaint: complaints/*complaints.where((element) => element.status=='pending')
                                        .toList()*/,),settings:const RouteSettings(
                                      name: '/submittedreport'
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
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(bottom: 5.0),
                                                    child: Text(
                                                      'Submitted Reports',
                                                      style: TextStyle(
                                                        color: Colors.cyanAccent,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(bottom: 0.0),
                                                    child: Text('(' + complaints.length.toString() + ')',
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                          color: Colors.black45,
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w400
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
                              ),
                              GestureDetector(
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
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(bottom: 5.0),
                                                    child: Text(
                                                      'Approved Reports',
                                                      style: TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:  EdgeInsets.only(bottom: 0.0),
                                                    child: Text('(' + complaints.where((element) => element.status=='approved').length.toString()
                                                      + ')',
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                          color: Colors.black45,
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w400
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
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                      ApprovedReport(approved_complaints: complaints.where((element) =>
                                      element.status=='approved').toList(),),settings: const RouteSettings(
                                      name: '/approvedreport'
                                  )));
                                },
                              ),
                              GestureDetector(
                                child:  Container(
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
                                                        color: Colors.orangeAccent,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(bottom: 0.0),
                                                    child: Text( '(' + complaints.where((element) => element.status=='declined').length
                                                      .toString() + ')',
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                          color: Colors.black45,
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w400
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
                                onTap: (){
                                  Navigator.push(
                                      context,MaterialPageRoute(builder: (context) =>
                                      DeclinedReport(declined_complaints:
                                      complaints.where((element) =>
                                      element.status=='declined').toList(),),settings: const RouteSettings(
                                      name: '/declinedreport'
                                  ))
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0,bottom: 10.0,left: 10.0,right: 10.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 52,
                                  child: TextButton(
                                    onPressed: () async{
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                      SubmitComplaint(),settings: const RouteSettings(
                                        name: '/submitcomplaint'
                                      ))).then((value){
                                        setState(() {
                                          future_landlord=null;
                                          future_landlord=getLandlordDetails();
                                        });
                                      });
                                    },
                                    child: const Text("Submit a report",style: TextStyle(color: Colors.white,
                                      fontSize: 14,),),
                                    style: TextButton.styleFrom(
                                        backgroundColor: AppConstants.primaryColor
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0,bottom: 10.0,left: 10.0,right: 10.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 52,
                                  child: TextButton(
                                    onPressed: () async{
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                          LandlordCheckStatus(),settings: const RouteSettings(
                                          name: '/landlordcheckstatus'
                                      )));
                                    },
                                    child: const Text("Check Status",style: TextStyle(color: Colors.white,
                                      fontSize: 14,),),
                                    style: TextButton.styleFrom(
                                        backgroundColor: AppConstants.primaryColor
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }

              else {
                return Container();
              }
            }

            else if(snapshot.connectionState==ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppConstants.thirdColor),
                ),
              );
            }

            else if(snapshot.hasError){
              return Center(
                child: Text("Error Occurred"),
              );
            }

            else{
              return Container();
            }
          },
        ),
      ),
    );
  }

  Future<dynamic> getDetails() async{
    var result=detailsRepository.getDetails();
    return result;
  }

  Future<dynamic> getLandlordDetails() async{
    print("The user id is " + Provider.of<Preferences>(context,listen: false)
        .user!.user_id.toString());
    var result=detailsRepository.getLandLordDetails(Provider.of<Preferences>(context,listen: false)
    .user?.user_id ?? 0);
    return result;
  }

  Future<dynamic> getComplaintCategories() async{
    var result=detailsRepository.getComplaintCategories();
    return result;
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
}