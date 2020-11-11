import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flipkartClone/screens/home_screen.dart';
import 'package:flipkartClone/screens/i18nDemo.dart';
import 'package:flipkartClone/utils/constants.dart';
import 'package:flutter/material.dart';
import './screens/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp(
    EasyLocalization(
      child: MyApp(),//the widget which it is supposes to call
      supportedLocales: [Locale('en','US'), Locale('hi', 'IN'),],//Locale(languageCode, CountryCode)
      path: 'assets/translations',
      fallbackLocale: Locale('en','US'),//this means if the locale is not there then by default it will use us locale

    ),
  );
  //file should be en-US instead of en_US

/*
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
  */
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //I18N needed a context therefore we have to make a widget as it has a context
        title: 'I18N Demo',
        home: I18NDemo(),
        //:::::::::::::::::::::::::
        locale: context.locale,//as easy_localization is entirely dependent on the context 
        //flutter tells if you use any third party modules for localization then we have to enable it then it will allow
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        //:::::::::::::::::::::::::
        );
  }
}

//new way of routing is to use route in main screen
