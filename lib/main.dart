import 'package:flutter/material.dart';
import 'package:geoapp/root_page.dart';
import 'package:geoapp/views/Dashboard/tenant_dashboard.dart';
import 'package:geoapp/views/Password/forgot_password.dart';
import 'package:provider/provider.dart';
import 'views/module.dart';
import 'constants/module.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/module.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> Preferences(user: User(id: 0,name: '',email: '',
      user_type: '',role_id: 0,created_at: '',updated_at: '',),
      user_id: 0,
        user_state: 'NOT_DETERMINED'
      ),),
    ],
    child: MaterialApp(
      builder: (context,Widget? child){
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(
              textScaleFactor: MediaQuery.of(context).size.width > 374 ? data.textScaleFactor * (1):
              data.textScaleFactor * (MediaQuery.of(context).size.width/375)
          ),
          child: child ?? Container(),
        );
      },
      routes: <String,WidgetBuilder>{
        '/signin':(BuildContext context) => SignIn(),
        '/signup':(BuildContext context) => SignUp(),
        '/splashscreen':(BuildContext context) => SplashScreen(),
        '/landlord':(BuildContext context) => LandlordDashboard(),
        '/submitedreport':(BuildContext context) => SubmittedReport(submitted_complaint: [],),
        '/declinedreport':(BuildContext context) => DeclinedReport(declined_complaints: [],),
        '/approvedreport' :(BuildContext context) => ApprovedReport(approved_complaints: [],),
        '/forgotpassword': (BuildContext context) => ForgotPassword(),
        '/tenantdashboard':(BuildContext context) => TenantDashboard(),
        '/myprofile':(BuildContext context) => MyProfile(),
        '/approveddocuments':(BuildContext context) => ApprovedDocuments(url: '',complaint: null,),
        '/submitcomplaint':(BuildContext context) => SubmitComplaint(),
        '/tenantstatus':(BuildContext context) => TenantStatus(isClear: false,national_id: '',
        reports: 0,),
        '/landlordcheckstatus':(BuildContext context) => LandlordCheckStatus(),
        '/landlordstatus':(BuildContext context) => LandlordStatus(isClear: false, national_id: '', reports: 0),
        '/verifyemail':(BuildContext context) => VerifyEmail(email: '',),
        '/resultdocument':(BuildContext context) => ResultDocuments(url: '', complaint: null),
        '/changepassword':(BuildContext context) => ChangePassword(email: '',),
        '/passwordotp':(BuildContext context) => PasswordOTP(email: '')
      },
      title: 'Flutter Demo',
      theme: appTheme,
      home: RootPage(),
    ),
    );
  }

  static ThemeData get appTheme=>
      ThemeData(
        //primaryColor: HexColor.fromHex("#D2EAF5"),
        //  accentColor: HexColor.fromHex("#4D86A0"),
        //  cardColor: HexColor.fromHex("#275D75"),
        //  scaffoldBackgroundColor: Colors.grey.shade100,
        //scaffoldBackgroundColor: HexColor.fromHex("#E5E5E5"),
        primaryColor: AppConstants.primaryColor,
        accentColor: AppConstants.secondaryColor,
        //   cardColor: AppConstants.thirdColor,
        scaffoldBackgroundColor: AppConstants.backgroundColor,
        fontFamily: GoogleFonts.inter().fontFamily,
        textTheme: GoogleFonts.interTextTheme(),
        visualDensity: VisualDensity.standard,

      );

}
