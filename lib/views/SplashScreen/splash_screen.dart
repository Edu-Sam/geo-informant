import 'package:flutter/material.dart';
import '../../constants/module.dart';
import '../../widget/module.dart';
import '../module.dart';

class SplashScreen extends StatefulWidget{
  SplashScreen({Key? key}):super(key: key);

  @override
  SplashScreenState createState()=> SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstants.primaryColor,
          elevation: 0,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppConstants.primaryColor,
          child: Padding(
            padding: EdgeInsets.only(
              top: 40.0
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                invony_logo(),
                const Padding(
                  padding: EdgeInsets.only(
                      bottom: 10.0,top: 10.0
                  ),
                  child: Text('WELCOME TO',style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400
                  ),),
                ),

                const Padding(
                  padding: EdgeInsets.only(
                      bottom: 10.0,top: 10.0
                  ),
                  child: Text('GEOINFORMANT',style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                  ),),
                ),
                Spacer(),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration: const BoxDecoration(
                      color: Colors.transparent,
                      border: Border(top: BorderSide(color: Colors.white,width: 0.0))
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.50,
                        height: 60,
                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            border: Border(right: BorderSide(color: Colors.white,width: 0.0))
                        ),
                        child: TextButton(
                          child: const Text('LOGIN',style: TextStyle( color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                SignIn(),settings:const RouteSettings(
                                name: '/signin'
                            )),);
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.50,
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: TextButton(
                          child: const Text('SIGN UP',style: TextStyle( color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                SignUp(),settings:const RouteSettings(
                                name: '/signup'
                            )),);
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ),
    );
  }

  Widget invony_logo(){
    return Container(
      width: 150,
      height: 150,
    //  width: MediaQuery.of(context).size.width * 0.35,
   //   height: MediaQuery.of(context).size.height * 0.35,
      decoration:const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle
      ),
      child: Center(
        child: Container(
            width: 120,
          height: 120,
          //width: MediaQuery.of(context).size.width * 0.28,
          //height: MediaQuery.of(context).size.height * 0.28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(
                'assets/images/geo_logo.jpg'
              )
            )
          ),
        )
      ),
    );
  }


}