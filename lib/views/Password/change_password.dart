import 'package:flutter/material.dart';
import '../../constants/module.dart';
import '../../models/module.dart';
import '../../services/module.dart';
import '../module.dart';


class ChangePassword extends StatefulWidget{
  ChangePassword({Key? key,required this.email}): super(key: key);
  String email;

  @override
  ChangePasswordState createState()=> ChangePasswordState();
}

 class ChangePasswordState extends State<ChangePassword>{

  TextEditingController password_controller=TextEditingController();
  TextEditingController confirm_password_controller= TextEditingController();
  List<String> types=['Landlord','Tenant'];
  int? current_value=0;
  DetailsRepository detailsRepository=DetailsRepository();
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
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,size: 28,color: Colors.grey,),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0,top: 60.0),
                    child: Text('Change \nPassword',style: TextStyle(
                        color: AppConstants.primaryColor,
                        fontSize: 32,
                        fontWeight: FontWeight.w800
                    ),),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 30.0,top: 20.0),
                    child: Text(
                      'Change your password in the form \nbelow.',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 11,fontWeight: FontWeight.w400
                      ),
                    ),
                  ),

                  Padding(
                    padding:const  EdgeInsets.only(top: 0.0,left: 20.0,right: 20.0),
                    child: Card(
                      elevation: 0,
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0,bottom: 5.0,),
                            child: Text("Password",style: TextStyle(
                                color: AppConstants.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600
                            ),),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(bottom: 5.0,),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 48,
                                child: TextFormField(
                                  controller: password_controller,
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
                    padding:const  EdgeInsets.only(top: 0.0,left: 20.0,right: 20.0),
                    child: Card(
                      elevation: 0,
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0,bottom: 5.0),
                            child: Text("Confirm Password",style: TextStyle(
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
                                  controller: confirm_password_controller,
                                  decoration:  InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Confirm Password',
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
                    padding: EdgeInsets.only(top: 10.0,left: 20.0,bottom: 10.0,right: 20.0),
                    child:  Container(
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
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 20.0,left: 20.0,right: 20.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 48,
                          child: TextButton(
                            onPressed: () async{
                              if(password_controller.text==confirm_password_controller.text){
                                setState(() {
                                  isLoading=true;
                                });
                                await changePassword(widget.email, password_controller.text,types.elementAt(
                                    current_value!)).then((value){
                                      setState(() {
                                        isLoading=false;
                                      });
                                  if(value is int){
                                    if(value==200){
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                          SignIn(),settings:const RouteSettings(
                                          name: '/signin'
                                      )),);
                                    }

                                    else{
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
                                    }
                                  }
                                  else{
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar1);
                                    print("error is not int");
                                  }
                                });
                              }
                            },
                            child: Text('RESET',style: TextStyle(color: Colors.white,
                              fontSize: 14,)
                            ),
                            style: TextButton.styleFrom(
                                backgroundColor: AppConstants.primaryColor
                            ),
                          )
                      )
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
        ) :
        Container()
      ],
    );
  }

  Future<dynamic> changePassword(String email,String password,String user_type) async{
    var result=await detailsRepository.changePassword(email, password, user_type);
    return result;
  }

  final snackBar = SnackBar(content: Text('Password reset successfully.',style: TextStyle(
      color: Colors.green
  ),));

  final snackBar1 = const SnackBar(content: Text('Unable to change password.Please try again',style: TextStyle(
      color: Colors.redAccent
  ),));
 }