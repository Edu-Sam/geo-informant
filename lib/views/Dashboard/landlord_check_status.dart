import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geoapp/views/Dashboard/tenant_status.dart';
import 'package:geoapp/widget/text_form_field.dart';
import '../../constants/module.dart';
import '../../services/module.dart';
import '../module.dart';

class LandlordCheckStatus extends StatefulWidget{
  LandlordCheckStatus({Key? key}):super(key:key);

  @override
  LandlordCheckStatuState  createState()=> LandlordCheckStatuState();
}

class LandlordCheckStatuState extends State<LandlordCheckStatus>{

  TextEditingController search_controller=TextEditingController();
  DetailsRepository detailsRepository=DetailsRepository();
  bool isLoading=false;



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(CupertinoIcons.chevron_back,color: AppConstants.primaryColor,
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),

          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 20.0,right: 20.0
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 60,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Check Tenant\n Status',
                              style: TextStyle(color: AppConstants.primaryColor,
                                  fontSize: 28,fontWeight: FontWeight.w800),),
                            IconButton(onPressed: (){

                            },
                                icon: const Icon(CupertinoIcons.gear,size: 30,color: Colors.grey,))
                          ],
                        )
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Text(
                        'Enter your Tenants ID \n Number below and click\nsearch to check his/her\nstatus',
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 60.0,left: 0.0,right: 16.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 48,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(1.0,1.0),
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                  color: Colors.grey.shade100
                              )
                            ]
                        ),
                        child: TextFormField(
                          controller: search_controller,
                          decoration:  InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade300,
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none
                            ),
                            disabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0,bottom: 10.0,left: 10.0,right: 10.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 52,
                        child: TextButton(
                          onPressed: () async{
                            setState(() {
                              isLoading=true;
                            });
                            await getTenantComplaint(search_controller.text).then((value){

                              if(value is int){
                                if(value==200){
                                  setState(() {
                                    isLoading=false;
                                  });
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>
                                      LandlordStatus(isClear: true,national_id: search_controller.text,
                                        reports: 0,),
                                      settings: const RouteSettings(name: '/landlordstatus')));
                                }

                                else{
                                  setState(() {
                                    isLoading=false;
                                  });
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>
                                      LandlordStatus(isClear: false,national_id: search_controller.text,
                                        reports: value,),
                                      settings: const RouteSettings(name: '/landlordstatus')));
                                }
                              }

                              else{
                                  setState(() {
                                    isLoading=false;
                                  });
                              }
                            });
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
              )
          ),
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
        ) :Container()
      ],
    );
  }

  Future<dynamic> getTenantComplaint(String tenant_national_id) async{
    var result=await detailsRepository.tenantComplaints(tenant_national_id);
    return result;
  }
}