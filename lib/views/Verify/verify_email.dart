import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geoapp/services/auth_repository.dart';
import 'package:geoapp/views/Dashboard/landlord_dashboard.dart';
import '../../constants/module.dart';
import '../../models/module.dart';
import 'package:provider/provider.dart';
import '../module.dart';

class VerifyEmail extends StatefulWidget{
  VerifyEmail({Key? key,required this.email}): super(key: key);
  String email;

  @override
  VerifyEmailState createState() => VerifyEmailState();
}

class VerifyEmailState extends State<VerifyEmail>{

  TextEditingController verify_controller=TextEditingController();
  AuthRepository authRepository=AuthRepository();
  bool isLoading=false;
  String error_message='';

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
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios,color: Colors.grey,size: 25,),
              onPressed: (){
                Navigator.pop(context);
              },
            ),),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0,left: 20.0),
                  child: Text("Verify Email ",style: TextStyle(
                    //  color: AppConstants.primaryColor,
                      color: Colors.green.shade800,
                      fontSize: 35,
                      fontWeight: FontWeight.w900
                  ),),
                ),

                const Padding(
                  padding: EdgeInsets.only(top: 30.0,left: 20.0),
                  child: Text(
                    'Enter the verification code you receive in\n'
                        'your email inbox to activate your account'
                    ,style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w500
                  ),),

                ),

                Padding(
                  padding:const  EdgeInsets.only(top: 50.0),
                  child: Card(
                    elevation: 0,
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:  EdgeInsets.only(top: 10.0,bottom: 5.0,left: 20.0),
                          child: Text("Verification Code",style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w500
                          ),),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 5.0,left: 20.0,right: 20.0,top: 10.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 48,
                              child: TextFormField(
                                controller: verify_controller,
                                obscureText: true,
                                decoration:  InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: '1234',
                                  hintStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,fontWeight: FontWeight.w500
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey.shade300),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey.shade300),
                                  ),
                                ),
                              ),
                            )
                        ),
                        error_message.isNotEmpty ?
                        Padding(
                          padding: EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0),
                          child: Text(
                            error_message,
                            style: TextStyle(color: Colors.red,fontSize: 12,fontWeight: FontWeight.w600),
                          ),
                        ): Container(),
                        Padding(
                            padding: const EdgeInsets.only(top: 60.0,left: 40.0,right: 40.0),
                            child: GestureDetector(
                              onTap: ()async{
                                setState(() {
                                  error_message='';
                                  isLoading=true;
                                });
                                var result=await verifyEmail(widget.email/*'edungugi20@gmail.com'*/, verify_controller.text);
                                if(result is Preferences){
                                  updateProvider(result);
                                  if(result.user!.user_type=='Landlord'){
                                    setState(() {
                                      isLoading=false;
                                    });
                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                        builder: (context)=> LandlordDashboard(),
                                        settings: const RouteSettings(name: '/landlord')
                                    ), (route) => false/* ModalRoute.withName('/')*/);
                                  }

                                  else if(result.user!.user_type=='Tenant'){
                                    setState(() {
                                      isLoading=false;
                                    });
                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                        builder: (context)=> TenantDashboard(),
                                        settings: const RouteSettings(name: '/tenantdashboard')
                                    ), (route) => false/* ModalRoute.withName('/')*/);
                                  }

                                  else{
                                    setState(() {
                                      isLoading=false;
                                      error_message='Authentication error.Please try again';

                                    });
                                  }
                                }

                                else{
                                  setState(() {
                                    isLoading=false;
                                    error_message=result;
                                  });
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 52,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(4.0,1.0),
                                          blurRadius: 2.0,
                                          spreadRadius: 3.0,
                                          color: Colors.grey.shade300
                                      )
                                    ]
                                ),

                                child: Center(
                                  child: Text('Verify',style: TextStyle(
                                      color: Colors.green.shade800,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600
                                  ),),
                                ),
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        isLoading ?
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black.withOpacity(0.4),
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                AppConstants.primaryColor
              ),
            ),
          ),
        ) :Container()
      ],
    );
  }

  Future<dynamic> verifyEmail(String email,String otp)async{
    var result=await authRepository.verifyOTP(otp, email,Provider.of<Preferences>(context,listen: false)
    );
    return result;
  }

  updateProvider(Preferences preferences){
    Provider.of<Preferences>(context,listen: false).isLoggedIn=true;
    Provider.of<Preferences>(context,listen: false).user=preferences.user;
    Provider.of<Preferences>(context,listen: false).user_state='LOGGED_IN';
   // Provider.of<Preferences>(context,listen: false).token=result['token'];
    Provider.of<Preferences>(context,listen: false).user_id=preferences.user_id;

  }
}