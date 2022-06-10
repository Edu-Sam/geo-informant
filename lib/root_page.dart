import 'package:flutter/material.dart';
import 'package:geoapp/auth/database-service.dart';
import 'package:geoapp/views/Dashboard/tenant_dashboard.dart';
import 'constants/module.dart';
import 'models/module.dart';
import 'views/module.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class RootPage extends StatefulWidget{
  RootPage({Key? key}):super(key: key);

  @override
  RootPageState createState()=> RootPageState();

}

enum AuthStatus{
  NOT_DETERMINED,
  NEW_USER,
  RAW_USER,
  LOGGED_IN,
  LOGGED_TENANT
}

class RootPageState extends State<RootPage>{

  AuthStatus authStatus=AuthStatus.NOT_DETERMINED;
  final Future<SharedPreferences> _prefs=SharedPreferences.getInstance();
  late SharedPreferences pref;
  late Preferences preferences;
  DatabaseService databaseService=DatabaseService();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setPreferences().then((value){
      getUser().then((value){
        setState(() {

        });
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    switch(authStatus){
      case AuthStatus.NOT_DETERMINED:
        return _buildWaitingScreen();
      case AuthStatus.NEW_USER:
        return SplashScreen();
      case AuthStatus.RAW_USER:
        return SignIn();
      case AuthStatus.LOGGED_IN:
        return LandlordDashboard();
      case AuthStatus.LOGGED_TENANT:
        return TenantDashboard();
      default:
        return SplashScreen();
    }

  }

  Widget invony_logo(){
    // isBlurred=false;

    return Center(
      child: GestureDetector(
        onTap: (){

        },
        child: Container(
          width:AppConstants.isBigger(getDeviceWidth()) ?250 : MediaQuery.of(context).size.width * 0.40,
          height: AppConstants.isBigger(getDeviceWidth())? 250:MediaQuery.of(context).size.height * 0.40,
          //   width:MediaQuery.of(context).size.width * 0.40,
          // height: MediaQuery.of(context).size.height * 0.40,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#D2EAF5"),
              // color: Colors.white,
              shape: BoxShape.circle
          ),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.30,
              height: MediaQuery.of(context).size.height * 0.30,
              //   width: MediaQuery.of(context).size.width * 0.20,
              //    height: MediaQuery.of(context).size.height * 0.15,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage("assets/images/cover.png"),
                      fit: BoxFit.contain
                  )
              ),
            ),
          ),
        ),
      ),
    );
  }

  double getDeviceWidth(){
    return MediaQuery.of(context).size.width;
  }

  Future<void> setPreferences() async{
    pref=await _prefs;
    if(pref.containsKey('user_state')){
      if(pref.getString('user_state')=='LOGGED_IN'){
        Provider.of<Preferences>(context,listen: false).user_state=pref.getString('user_state') ?? 'LOGGED_IN';
        print('The state on startup is ' + Provider.of<Preferences>(context,listen: false).user_state);

      }

      else if(pref.getString('user_state')=='LOGGED_TENANT'){
        Provider.of<Preferences>(context,listen: false).user_state=pref.getString('user_state') ?? 'LOGGED_TENANT';
        print('The state on startup is ' + Provider.of<Preferences>(context,listen: false).user_state);

      }
      else if(pref.getString('user_state')=='RAW_USER'){
        Provider.of<Preferences>(context,listen: false).user_state=pref.getString('user_state') ?? 'RAW_USER';
        print('The state on startup is ' + Provider.of<Preferences>(context,listen: false).user_state);
      }

      else if(pref.getString('user_state')=='NEW_USER'){
        pref.setString('user_state', 'NEW_USER' );
        Provider.of<Preferences>(context,listen: false).user_state=pref.getString('user_state') ?? 'NEW_USER';

      }

      else{
        pref.setString('user_state', 'NEW_USER' );
        Provider.of<Preferences>(context,listen: false).user_state=pref.getString('user_state') ?? 'NEW_USER';
      }
    }

    else{
      pref.setString('user_state', 'NEW_USER' );
      Provider.of<Preferences>(context,listen: false).user_state=pref.getString('user_state') ?? 'NEW_USER';
    }
  }

  Future<dynamic> getUser() async{
    preferences=Provider.of<Preferences>(context,listen: false);

    if(preferences.user_state=='LOGGED_IN'){
      await createLoggedIn();
     authStatus=AuthStatus.LOGGED_IN;
    }

    else if(preferences.user_state=='RAW_USER'){
      await createRawProfile();
      authStatus=AuthStatus.RAW_USER;
    }

    else if(preferences.user_state=='NEW_USER'){
      await createNewProfile();
      authStatus=AuthStatus.NEW_USER;
    }

    else if(preferences.user_state=='LOGGED_TENANT'){
      await createLoggedIn();
      authStatus=AuthStatus.LOGGED_TENANT;
    }

    else{
    //  await createNewProfile();
      authStatus=AuthStatus.NOT_DETERMINED;
    }
  }

  Future<dynamic> createLoggedIn() async{
    var result=await databaseService.getPreferences(1);
    if(result is Preferences){
      Provider.of<Preferences>(context,listen: false).user_state=result.user_state;
      Provider.of<Preferences>(context,listen: false).user=result.user;
      Provider.of<Preferences>(context,listen: false).user_id=result.user_id;
      Provider.of<Preferences>(context,listen: false).isLoggedIn=result.isLoggedIn;
      Provider.of<Preferences>(context,listen: false).id=result.id;


      return Provider.of<Preferences>(context,listen: false);
    }

    else{
      return null;
    }
  }

  Future<dynamic> createRawProfile() async{
    Provider.of<Preferences>(context,listen: false).user_state='RAW_USER';
    Provider.of<Preferences>(context,listen: false).user=User(name: '',email: '',user_type: '',password: '',
    mobile: '');
    Provider.of<Preferences>(context,listen: false).user_id=0;
    Provider.of<Preferences>(context,listen: false).isLoggedIn=false;

    return Provider.of<Preferences>(context,listen: false);
  }

  Future<dynamic> createNewProfile() async{
    Provider.of<Preferences>(context,listen: false).user_state='NEW_USER';
    Provider.of<Preferences>(context,listen: false).user=User(name: '',email: '',user_type: '',password: '',
        mobile: '');
    Provider.of<Preferences>(context,listen: false).user_id=0;
    Provider.of<Preferences>(context,listen: false).isLoggedIn=false;

    return Provider.of<Preferences>(context,listen: false);
  }


  Widget _buildWaitingScreen(){
    return Material(
      color: Colors.white,
      child: Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),
    );
  }




}