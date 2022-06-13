import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../constants/module.dart';
import '../../models/module.dart';
import '../module.dart';
import '../../services/module.dart';

class ForgotPassword extends StatefulWidget{
  ForgotPassword({Key? key}): super(key: key);

  @override
  ForgotPasswordState createState()=> ForgotPasswordState();

}

class ForgotPasswordState extends State<ForgotPassword>{

  TextEditingController email_controller=TextEditingController();
  Validation validation=Validation();
  GlobalKey<FormState> form_key=GlobalKey<FormState>();
  List<String> types=['Landlord','Tenant'];
  int? current_value=0;
  DetailsRepository detailsRepository=DetailsRepository();
  String error_message='';
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
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(icon: const Icon(CupertinoIcons.back,size: 30,color: Colors.grey,),
              onPressed: (){
                 Navigator.pop(context);
              },),
          ),
          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child:Form(
                  key: form_key,
                  child:  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0,top: 60.0),
                          child: Text('Forgot\nPassword',style: TextStyle(
                              color: AppConstants.primaryColor,
                              fontSize: 32,
                              fontWeight: FontWeight.w800
                          ),),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 30.0,top: 20.0),
                          child: Text(
                            'Enter your email below to receive your password reset \ninstructions.',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 11,fontWeight: FontWeight.w400
                            ),
                          ),
                        ),

                        const Padding(
                          padding: EdgeInsets.only(top: 50.0,left: 30.0),
                          child: Text(
                            'Email',style: TextStyle(
                              color: Colors.black54,
                              fontSize: 11,fontWeight: FontWeight.w400
                          ),),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: 50,
                            child: TextFormField(
                              controller: email_controller,
                              validator: (text){
                                return validation.emailValidator(text ?? '', context);
                              },
                              decoration: const InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey)
                                  ),
                                  filled: true,
                                  fillColor: Colors.white
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 20.0,left: 20.0,right: 20.0),
                          child: Container(
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

                        error_message.isNotEmpty ?
                        Padding(
                          padding: EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0),
                          child: Text(
                            error_message,style: TextStyle(color: Colors.red,
                              fontSize: 12,fontWeight: FontWeight.w600),
                          ),
                        ):Container(),

                        Padding(
                          padding: const EdgeInsets.only(top: 20.0,left: 20.0,right: 20.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: const BoxDecoration(
                                color:Colors.white,
                                boxShadow:  [
                                  BoxShadow(
                                      offset: Offset(2.0,2.0),
                                      blurRadius: 2.0,
                                      spreadRadius: 2.0,
                                      color: Colors.black12
                                  )
                                ]
                            ),
                            child: TextButton(
                              child: Text('Reset Password',style: TextStyle(color: AppConstants.primaryColor,
                                  fontSize: 15,fontWeight: FontWeight.w800),),
                              onPressed: () async{
                                if(form_key.currentState!.validate()){
                                  setState(() {
                                    isLoading=true;
                                  });
                                  await getOTP(email_controller.text, types.elementAt(current_value!)).then((value){
                                    setState(() {
                                      isLoading=false;
                                    });
                                    if(value is int){
                                      if( value==200){
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        Navigator.push(
                                            context,MaterialPageRoute(builder: (context) => PasswordOTP(email: email_controller
                                        .text),settings:
                                        RouteSettings(name: '/passwordotp'))
                                        );
                                      }

                                      else{
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar1);
                                      }
                                    }

                                    else{
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
                                    }
                                  });
                                }
                                /*Navigator.push(
                          context,MaterialPageRoute(builder: (context) => ChangePassword(),settings:
                      RouteSettings(name: '/changepassword'))
                      );*/
                              },
                              /* style: TextButton.styleFrom(
                    shadowColor: Colors.black12
                  ),*/
                            ),
                          ),
                        )

                      ],
                    ),
                  )
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
        ):
        Container()
      ],
    );
  }

  Future<dynamic> getOTP(String email,String user_type) async{
    var result= await detailsRepository.getOTP(email, user_type);
    return result;
  }

  String getEmail(){
    return email_controller.text;
  }

  final snackBar = SnackBar(content: Text('OTP has been sent to email.',style: TextStyle(
      color: Colors.green
  ),));

  final snackBar1 = const SnackBar(content: Text('Unable to send OTP.Please try again',style: TextStyle(
      color: Colors.redAccent
  ),));
}