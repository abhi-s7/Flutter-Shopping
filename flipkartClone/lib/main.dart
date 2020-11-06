import 'package:firebase_core/firebase_core.dart';
import 'package:flipkartClone/screens/home_screen.dart';
import 'package:flipkartClone/utils/constants.dart';
import 'package:flutter/material.dart';
import './screens/splashscreen.dart';
void main() {
  
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp(MaterialApp(title:'Flipkart Clone',
  debugShowCheckedModeBanner: false,
  //home: SplashScreen(),//it will have confliction as we have specified routes and it have home route
   routes: <String, WidgetBuilder>{
     //String - Name of Route
     //WidgetBuilder - Because it is going to build a widget

    '/': (BuildContext context)=>SplashScreen(),
    Constant.HOME_ROUTE : (ctx)=> HomeScreen()
    //all the routes of application will be maintained here
  },));
}
//new way of routing is to use route in main screen
