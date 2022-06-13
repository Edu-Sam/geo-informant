import 'package:flutter/material.dart';
import 'package:geoapp/services/auth_repository.dart';
import '../../constants/module.dart';
import 'package:flutter/cupertino.dart';
import '../module.dart';
import '../../models/module.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:core';

class SignUp extends StatefulWidget{
  SignUp({Key? key}):super(key: key);

  @override
  SignUpState createState()=> SignUpState();
}

class SignUpState extends State<SignUp>{

  TextEditingController username_controller=TextEditingController();
  TextEditingController email_controller=TextEditingController();
  TextEditingController mobile_controller=TextEditingController();
  TextEditingController password_controller=TextEditingController();
  TextEditingController landlord_controller=TextEditingController();
  List<String> types=['Landlord','Tenant'];
  int? current_value=0;
  AuthRepository authRepository=AuthRepository();
  Validation validation=Validation();
  GlobalKey<FormState> form_key=GlobalKey<FormState>();
  bool isLoading=false;
  String error_message='';
  bool? is_terms=false;

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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 20.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.80,
                          color: Colors.white,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 5.0),
                                      child: Text("Create an Account",style: TextStyle(
                                          color: AppConstants.primaryColor,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w800
                                      ),),
                                    ),
                                    Padding(
                                      padding:const  EdgeInsets.only(top: 10.0),
                                      child: Card(
                                        elevation: 0,
                                        color: Colors.transparent,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 20.0,bottom: 5.0),
                                              child: Text("Username",style: TextStyle(
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
                                                    controller: username_controller,
                                                    validator: (text){
                                                      return validation.nameValidator(text ?? '', context);
                                                    },
                                                    decoration:  InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      hintText: 'Enter Username',
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
                                                  //    height: 48,
                                                  child: TextFormField(
                                                    controller: email_controller,
                                                    validator: (text){
                                                      return validation.emailValidator(text ?? '', context);
                                                    },
                                                    decoration:  InputDecoration(
                                                      filled: true,
                                                      //      isCollapsed: true,
                                                      fillColor: Colors.white,
                                                      hintText: 'Email',
                                                      contentPadding: EdgeInsets.all(9),
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
                                              child: Text("Mobile",style: TextStyle(
                                                  color: AppConstants.primaryColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600
                                              ),),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(bottom: 5.0),
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  //    height: 48,
                                                  child: TextFormField(
                                                    controller: mobile_controller,
                                                    validator: (text){
                                                      return validation.phoneValidator(text ?? '', context);
                                                    },
                                                    decoration:  InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      hintText: '07xxxxxxxx',
                                                      contentPadding: const EdgeInsets.all(9),
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
                                                      hintText: 'Password',
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
                                              child: Text("Sign up As",style: TextStyle(
                                                  color: AppConstants.primaryColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600
                                              ),),
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
                                                                hint: const Text("Sign Up As",style: TextStyle(color: Colors.lightBlueAccent,
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

                                          ],
                                        ),
                                      ),
                                    ),
                                    error_message.isNotEmpty ?
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0,left: 20.0),
                                      child: Text(error_message,style: const TextStyle(
                                          color: Colors.red,fontSize: 12,
                                          fontWeight: FontWeight.bold
                                      ),),
                                    ):Container(),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 0.0),
                                      child: Row(
                                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Checkbox(
                                            value: is_terms,
                                            onChanged: (value){
                                              setState(() {
                                                is_terms=value;
                                              });
                                            },
                                          ),
                                          Row(
                                            children: [
                                              Text("I agree to the ",style: TextStyle(color: Colors.black54,fontSize: 15,
                                                  fontWeight: FontWeight.w400),),
                                              GestureDetector(
                                                onTap: () async{
                                                  const url = 'https://php74.clifford.co.ke/geoinformant/public/details/terms';
                                                  if (await canLaunchUrl(Uri.parse(url))) {
                                                    /*await launchUrl(Uri(path: url,
                                                      query: encodeQueryParameters(<String, String>{
                                                        'subject': 'Example Subject & Symbols are allowed!'
                                                      }),
                                                    ));*/
                                                    await launchUrl(Uri.parse(url));
                                                  } else {
                                                   setState(() {
                                                     error_message='Network error:'
                                                         'Please check your internet connection!';
                                                   });
                                                    // throw 'Could not launch $url';
                                                  }
                                                },
                                                child: Text("Terms of Service",style: TextStyle(color: AppConstants.primaryColor,fontSize: 15,
                                                    fontWeight: FontWeight.w500),),
                                              )
                                            ],
                                          )

                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 48,
                                        child: TextButton(
                                          onPressed: () async{
                                            /*Navigator.push(context, MaterialPageRoute(
                                              builder: (context)=>
                                              VerifyEmail(email: email_controller.text,)
                                            ,settings: const RouteSettings(
                                              name: '/verifyemail'
                                            )),);*/
                                            if(form_key.currentState!.validate() && is_terms!){
                                               setState(() {
                                                 isLoading=true;
                                               });
                                              await signUp().then((value){
                                                if(value is String){
                                                  if(value.isEmpty){
                                                    setState(() {
                                                      isLoading=false;
                                                      error_message='';

                                                    });

                                                    /*Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                                        LandlordDashboard(),settings:const  RouteSettings(
                                                        name: '/landlord'
                                                    )));*/
                                                    Navigator.push(context, MaterialPageRoute(
                                                        builder: (context)=>
                                                            VerifyEmail(email: email_controller.text,)
                                                        ,settings: const RouteSettings(
                                                        name: '/verifyemail'
                                                    )),);
                                                  }

                                                  else{
                                                     setState(() {
                                                       isLoading=false;
                                                       error_message=value;

                                                     });
                                                  }
                                                }

                                                else{
                                                  setState(() {
                                                    isLoading=false;
                                                    error_message='Error Occurred.Please Try again';
                                                  });
                                                }
                                              });
                                            }

                                            else if(is_terms==null || is_terms==false){
                                              setState(() {
                                                error_message='Please accept the terms of service';
                                              });
                                            }
                                          },
                                          child: const Text("NEXT",style: TextStyle(color: Colors.white,
                                            fontSize: 14,),),
                                          style: TextButton.styleFrom(
                                              backgroundColor: AppConstants.primaryColor
                                          ),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: AppConstants.horizontal_margin),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                                  SignIn(),settings: const RouteSettings(
                                                  name: '/signin'
                                              )));
                                            },
                                            child: const Text("Already a member?Login",style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,fontWeight: FontWeight.w400
                                            ),),
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              )
                          ),
                        ),
                      )
                    ],
                  ),
                )
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
              valueColor: AlwaysStoppedAnimation<Color>(AppConstants.primaryColor),
            ),
          ),
        )  :
       Container()
      ],
    );
  }

  Future<dynamic> signUp() async{
    String username=username_controller.text;
    String email=email_controller.text;
    String mobile=mobile_controller.text;
    String password=password_controller.text;
    String type=types.elementAt(current_value??0);

    User user=User(name: username,email: email,user_type: type,password: password,mobile: mobile);


    var result=await authRepository.signup(user);
    return result;
  }
}