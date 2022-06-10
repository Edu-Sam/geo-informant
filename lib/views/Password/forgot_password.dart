import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../constants/module.dart';

class ForgotPassword extends StatefulWidget{
  ForgotPassword({Key? key}): super(key: key);

  @override
  ForgotPasswordState createState()=> ForgotPasswordState();

}

class ForgotPasswordState extends State<ForgotPassword>{

  TextEditingController email_controller=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(icon: const Icon(CupertinoIcons.forward,size: 30,),
        onPressed: (){

        },),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0,top: 120.0),
              child: Text('Forgot\nPassword',style: TextStyle(
                color: AppConstants.primaryColor,
                fontSize: 32,
                fontWeight: FontWeight.w800
              ),),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30.0,top: 20.0),
              child: Text(
                'Enter your email below to receive your \npassword reset instructions.',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 11,fontWeight: FontWeight.w400
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(top: 80.0,left: 30.0),
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
                  onPressed: (){

                  },
                 /* style: TextButton.styleFrom(
                    shadowColor: Colors.black12
                  ),*/
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}