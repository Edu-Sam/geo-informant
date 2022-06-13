import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geoapp/auth/database-service.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/module.dart';
import '../../constants/module.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../module.dart';

class MyProfile extends StatefulWidget{
  MyProfile({Key? key}):super(key: key);

  @override
  MyProfileState createState()=> MyProfileState();
}

class MyProfileState extends State<MyProfile>{

  final Future<SharedPreferences> _prefs=SharedPreferences.getInstance();
  late SharedPreferences pref;
  DatabaseService databaseService=DatabaseService();
  bool isLoading=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios,color: Colors.grey,size: 24,),
              onPressed: (){
                Navigator.pop(context);
              },
            ),),

          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child:  Text("My Profile",style: TextStyle(
                        //  color: AppConstants.primaryColor,
                          color: AppConstants.primaryColor,
                          fontSize: 30,
                          fontWeight: FontWeight.w900
                      ),),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.08,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(1.0,1.0),
                                  blurRadius: 1.0,
                                  spreadRadius: 1.0,
                                  color: Colors.black12
                              )
                            ]
                        ),

                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0,horizontal: 16.0
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Padding(
                                padding: EdgeInsets.only(bottom: 3.0),
                                child: Text('Name',style: TextStyle(color: Colors.grey.shade400,fontSize: 16,
                                    fontWeight: FontWeight.w500,fontFamily: GoogleFonts.roboto().fontFamily),),
                              ),
                              Text(Provider.of<Preferences>(context,listen: false).user!.name,style: TextStyle(color: Colors.grey.shade600,fontSize: 18,
                                  fontWeight: FontWeight.w500,fontFamily: GoogleFonts.roboto().fontFamily),),

                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.08,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(1.0,1.0),
                                  blurRadius: 1.0,
                                  spreadRadius: 1.0,
                                  color: Colors.black12
                              )
                            ]
                        ),

                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0,horizontal: 16.0
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Padding(
                                padding: EdgeInsets.only(bottom: 3.0),
                                child: Text('Mobile No.',style: TextStyle(color: Colors.grey.shade400,fontSize: 16,
                                    fontWeight: FontWeight.w500,fontFamily: GoogleFonts.roboto().fontFamily),),
                              ),
                              Text(Provider.of<Preferences>(context,listen: false).user!.mobile.toString(),style: TextStyle(color: Colors.grey.shade600,fontSize: 18,
                                  fontWeight: FontWeight.w500,fontFamily: GoogleFonts.roboto().fontFamily),),

                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.08,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(1.0,1.0),
                                  blurRadius: 1.0,
                                  spreadRadius: 1.0,
                                  color: Colors.black12
                              )
                            ]
                        ),

                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0,horizontal: 16.0
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Padding(
                                padding: EdgeInsets.only(bottom: 3.0),
                                child: Text('Email Address',style: TextStyle(color: Colors.grey.shade400,fontSize: 16,
                                    fontWeight: FontWeight.w500,fontFamily: GoogleFonts.roboto().fontFamily),),
                              ),
                              Text(Provider.of<Preferences>(context,listen: false).user!.email,style: TextStyle(color: Colors.grey.shade600,fontSize: 18,
                                  fontWeight: FontWeight.w500,fontFamily: GoogleFonts.roboto().fontFamily),),

                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        //   height: MediaQuery.of(context).size.height * 0.07,
                        decoration: const BoxDecoration(
                          color: Colors.white,

                        ),

                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0,horizontal: 16.0
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Padding(
                                padding: EdgeInsets.only(bottom: 3.0),
                                child: Text('To change your Mobile Number and Email\nAddress please send an email to\n'
                                    'info@geoinformant.com ',style: TextStyle(color: Colors.grey.shade600,fontSize: 12,
                                    fontWeight: FontWeight.w400,fontFamily: GoogleFonts.roboto().fontFamily),),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 40.0,horizontal: 10.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 48,
                                  child: TextButton(
                                    onPressed: () async{

                                    },
                                    child: const Text("Deactivate & Delete Account",style: TextStyle(color: Colors.white,
                                      fontSize: 14,),),
                                    style: TextButton.styleFrom(
                                        backgroundColor: AppConstants.primaryColor
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 40.0,horizontal: 10.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 48,
                                  child: TextButton(
                                    onPressed: () async{
                                       setState(() {
                                         isLoading=true;
                                       });

                                       await logout().then((value){
                                         setState(() {
                                           isLoading=false;
                                         });


                                         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                             builder: (context)=> SplashScreen(),
                                             settings: const RouteSettings(name: '/splashscreen')
                                         ), (route) => false
                                         /*ModalRoute.withName('/splashscreen')*/);
                                       });
                                    },
                                    child: const Text("Logout",style: TextStyle(color: Colors.white,
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
        )    :
        Container()
      ],
    );
  }

  Future<void>logout() async{
    pref=await _prefs;
     pref.setString('user_state', 'NEW_USER');

     await databaseService.deleteAccount().then((value) async{
       await databaseService.deleteUser().then((deletedUser){

       });
     });
  }
}