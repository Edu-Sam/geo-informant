import 'package:flutter/material.dart';
import 'package:geoapp/constants/module.dart';
import 'package:flutter/cupertino.dart';

class LandlordStatus extends StatefulWidget{
  LandlordStatus({Key? key,required this.isClear,required this.national_id,
    required this.reports}): super(key:key);
  bool isClear;
  String national_id;
  int reports;

  @override
  _LandlordStatuState createState()=> _LandlordStatuState();
}

class _LandlordStatuState extends State<LandlordStatus>{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.chevron_back,color: AppConstants.primaryColor,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
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
                        Text('Status',
                          style: TextStyle(color: AppConstants.primaryColor,
                              fontSize: 28,fontWeight: FontWeight.w800),),

                      ],
                    )
                ),
                widget.reports==0 ?
                Column(
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(top: 90),
                        child: Center(
                          child: Icon(
                            CupertinoIcons.check_mark_circled,size: 180,color: Colors.green,
                          ),
                        )
                    ),

                    Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Center(
                          child: Text('Id: ' + widget.national_id,style: const TextStyle(
                              color: Colors.blue,fontSize: 16,fontWeight: FontWeight.w500
                          ),),
                        )
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 30.0,left: 20.0),
                      child: Text('There are no reports listed\n'
                          'with GeoInformant for \n this Tenant.',textAlign: TextAlign.center,style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,

                      ),),
                    ),


                  ],
                )
                    :Column(
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(top: 90),
                        child: Center(
                          child: Icon(
                            CupertinoIcons.clear_circled,size: 180,color: Colors.redAccent,
                          ),
                        )
                    ),

                    Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Center(
                          child: Text('Id: ' + widget.national_id,style: const TextStyle(
                              color: Colors.blue,fontSize: 16,fontWeight: FontWeight.w500
                          ),),
                        )
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 30.0,left: 20.0),
                      child: Text(' ${widget.reports.toString()} report(s) listed\n'
                          'for this Tenant with\nGeoInformant.',textAlign: TextAlign.center,style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,

                      ),),
                    ),

                    const Padding(
                      padding: EdgeInsets.only(top: 30.0,left: 20.0),
                      child: Text('Please contact \n info@geoinformant.com\nFor more information',textAlign: TextAlign.center,style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,

                      ),),
                    ),
                  ],
                )
              ],
            ),
          )
      ),
    );
  }
}