import 'package:flutter/material.dart';
import 'package:geoapp/views/Dashboard/landlord_dashboard.dart';
import 'package:geoapp/views/Dashboard/tenant_dashboard.dart';
import 'package:geoapp/views/Password/forgot_password.dart';
import '../../constants/module.dart';
import 'package:flutter/cupertino.dart';
import '../../services/module.dart';
import '../../models/module.dart';
import 'package:provider/provider.dart';
import '../module.dart';

class SignIn extends StatefulWidget{
  SignIn({Key? key}):super(key: key);

  @override
  SignInState createState()=> SignInState();
}

class SignInState extends State<SignIn>{

  TextEditingController email_controller=TextEditingController();
  TextEditingController password_controller=TextEditingController();
  int? current_value=0;

  AuthRepository authRepository=AuthRepository();
  bool isLoading=false;
  GlobalKey<FormState> form_key=GlobalKey<FormState>();
  Validation validation=Validation();
  String error_message='';
  List<String> types=['Landlord','Tenant'];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Scaffold(
          appBar:AppBar(
            leading: IconButton(
              icon: const Icon(CupertinoIcons.clear,color: Colors.white,),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            backgroundColor: AppConstants.primaryColor,
            elevation: 0,
          ) ,
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: AppConstants.primaryColor,
            child: Form(
              key: form_key,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.80,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 5.0),
                              child: Text("Login",style: TextStyle(
                                  color: AppConstants.primaryColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800
                              ),),
                            ),

                            Padding(
                              padding:const  EdgeInsets.only(top: 0.0),
                              child: Card(
                                elevation: 0,
                                color: Colors.transparent,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0,bottom: 5.0),
                                      child: Text("Email",style: TextStyle(
                                          color: AppConstants.primaryColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600
                                      ),),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(bottom: 5.0),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 48,
                                          child: TextFormField(
                                            controller: email_controller,
                                            decoration:  InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              hintText: 'Email',
                                              hintStyle: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,fontWeight: FontWeight.w500
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.grey.shade300),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.grey.shade300),
                                              ),
                                            ),
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              ),
                            ),

                            Padding(
                              padding:const  EdgeInsets.only(top: 0.0),
                              child: Card(
                                elevation: 0,
                                color: Colors.transparent,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0,bottom: 5.0),
                                      child: Text("Password",style: TextStyle(
                                          color: AppConstants.primaryColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600
                                      ),),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(bottom: 5.0),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 48,
                                          child: TextFormField(
                                            controller: password_controller,
                                            obscureText: true,
                                            decoration:  InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              hintText: 'Enter Password',
                                              hintStyle: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,fontWeight: FontWeight.w500
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.grey.shade300),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.grey.shade300),
                                              ),
                                            ),
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              ),
                            ),

                            Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                                child: Align(
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                            ForgotPassword()));
                                      },
                                      child: const Text("Forgot your password?",style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,fontWeight: FontWeight.w400
                                      ),),
                                    )
                                )
                            ),
                            Container(
                                color: Colors.white,
                                height: 60,
                                child: FormField(
                                    builder: (FormFieldState state){
                                      return InputDecorator(

                                          decoration:  InputDecoration(
                                            contentPadding: EdgeInsets.all(5.0),
                                            //     labelStyle: textStyle,
                                            errorStyle: const TextStyle(color: Colors.redAccent,fontSize: 16.0),
                                            hintStyle: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.grey.shade300),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.grey.shade300),
                                            ),
                                            // labelText:'Select Bank',
                                          ),
                                          child:DropdownButtonHideUnderline(
                                              child:DropdownButton(
                                                value: current_value,
                                                isDense: true,
                                                hint: const Text("Sign In As",style: TextStyle(color: Colors.lightBlueAccent,
                                                    fontSize: 10),),

                                                onChanged: (int? newValue){
                                                  //                setState((){
                                                  current_value=newValue;
                                                  state.didChange(newValue);
                                                  //               });
                                                },
                                                icon: null,
                                                //  icon: const Icon(Icons.keyboard_arrow_down),
                                                items:types.map((value){
                                                  return DropdownMenuItem(
                                                    value: types.indexOf(value),
                                                    child:Text(value),
                                                  );
                                                }).toList(),
                                              )
                                          )
                                      );

                                    }
                                )
                            ),
                           /* Padding(
                              padding: const EdgeInsets.only(top: 40.0,bottom: 10.0,left: 10.0,right: 10.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 48,
                                child: TextButton(
                                  onPressed: () async{
                                    setState(() {
                                      isLoading=true;
                                    });

                                    setState(() {
                                      error_message='';
                                    });

                                    var result=await authRepository.signIn(email_controller.text, password_controller.text,
                                        Provider.of<Preferences>(context,listen: false));
                                    if(result is Preferences && result.user!.user_type!='Landlord'){
                                      setState(() {
                                        isLoading=false;
                                      });

                                      createTenantProfile(result);

                                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                          builder: (context)=> TenantDashboard(),
                                          settings: const RouteSettings(name: '/tenantdashboard')
                                      ), (route) => false/* ModalRoute.withName('/')*/);
                                    }

                                    else{
                                      setState(() {
                                        error_message='Unable to Sign in tenant';
                                      });
                                      setState(() {
                                        isLoading=false;
                                      });

                                      print("Error Occured");
                                    }


                                  },
                                  child: const Text("LOGIN TENANT",style: TextStyle(color: Colors.white,
                                    fontSize: 14,),),
                                  style: TextButton.styleFrom(
                                      backgroundColor: AppConstants.primaryColor
                                  ),
                                ),
                              ),
                            ),*/
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 48,
                                child: TextButton(
                                  onPressed: () async{
                                    setState(() {
                                      isLoading=true;
                                      error_message='';
                                    });

                                    var result=await authRepository.signIn(email_controller.text/*'lansre@example.com'*/,
                                    /*'theadmin'*/password_controller.text,
                                        Provider.of<Preferences>(context,listen: false));
                                    print("email is " + email_controller.text + ':' + password_controller.text);
                                    if(result is Preferences && result.user!.user_type=='landlord' && current_value==0){
                                      setState(() {
                                        isLoading=false;
                                      });

                                      createLandlordProfile(result);
                                      //Provider.of<Preferences>(context,listen: false).user=result.user;
                                     /* Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                          LandlordDashboard(),settings: const RouteSettings(
                                          name: '/landlord'
                                      )));*/
                                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                          builder: (context)=> LandlordDashboard(),
                                          settings: const RouteSettings(name: '/landlord')
                                      ), (route) => false/* ModalRoute.withName('/')*/);
                                    }

                                    else if(result is Preferences && result.user!.user_type=='Tenant' && current_value==1){
                                      setState(() {
                                        isLoading=false;
                                      });

                                      createTenantProfile(result);
                                      //createLandlordProfile(result);
                                      //Provider.of<Preferences>(context,listen: false).user=result.user;
                                      /* Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                          LandlordDashboard(),settings: const RouteSettings(
                                          name: '/landlord'
                                      )));*/
                                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                          builder: (context)=> TenantDashboard(),
                                          settings: const RouteSettings(name: '/tenantdashboard')
                                      ), (route) => false/* ModalRoute.withName('/')*/);
                                      /*setState(() {
                                        isLoading=false;
                                        error_message='Unable to Sign in landlord';
                                      });
                                      print("Error Occured");*/
                                    }

                                    else{
                                    setState(() {
                                      isLoading=false;
                                      error_message='Authentication error.Please try again';
                                    });


                                    }




                                  },
                                  child: const Text("LOGIN",style: TextStyle(color: Colors.white,
                                    fontSize: 14,),),
                                  style: TextButton.styleFrom(
                                      backgroundColor: AppConstants.primaryColor
                                  ),
                                ),
                              ),
                            ),
                            error_message.isNotEmpty ?
                            Padding(
                              padding: EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0),
                              child: Text(
                                error_message,style: TextStyle(color: Colors.red,
                              fontSize: 12,fontWeight: FontWeight.w600),
                              ),
                            ):Container(),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)
                                        => SignUp(),settings: const RouteSettings(
                                            name: '/signup'
                                        )));
                                      },
                                      child: const Text("You dont have an account?Signup",style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,fontWeight: FontWeight.w400
                                      ),),
                                    )
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
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
        ):Container()
      ],
    );
  }

  Future<dynamic> signIn(String email,String password,Preferences preferences) async{
    var result=await authRepository.signIn(email, password,preferences);
    return result;
  }

  createLandlordProfile(Preferences preferences){
   Provider.of<Preferences>(context,listen: false).user_state=preferences.user_state;
   Provider.of<Preferences>(context,listen: false).isLoggedIn=true;
   Provider.of<Preferences>(context,listen: false).user=preferences.user;
   Provider.of<Preferences>(context,listen: false).user_id=preferences.user_id;
   //Provider.of<Preferences>(context,listen: false).user_id=user.
  }

  createTenantProfile(Preferences preferences){
    Provider.of<Preferences>(context,listen: false).user_state=preferences.user_state;
    Provider.of<Preferences>(context,listen: false).isLoggedIn=true;
    Provider.of<Preferences>(context,listen: false).user=preferences.user;
    Provider.of<Preferences>(context,listen: false).user_id=preferences.user_id;
  }
}