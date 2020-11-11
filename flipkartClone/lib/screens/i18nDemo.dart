import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
//internationalization
/*
Decide on day one because there should not be any hardcoding as we have to use the String from json file of i18N
This is done when the screen is run thus it is compile time
So for the run time use  google translate

dependency - easy_localizaiton
Add translation file
    - assets/translations/
And in JSON use
{
    "msg": "Hello",
    "msg2": "HI"
}
thus instead of using 'Hello' use msg everywhere using tr() - translate
Also in main.dart use EasyLoxalization widget
::: it requires 'context' and it is only available in stateless or stateful widget
Thus make a widget but don't directly use in runApp()
*/
class I18NDemo extends StatefulWidget {
  @override
  _I18NDemoState createState() => _I18NDemoState();
}

class _I18NDemoState extends State<I18NDemo> {
  bool flag = false;

  _changeLang() {
    if (flag) {
      EasyLocalization.of(context).locale = Locale('en', 'US');
    } else {
      EasyLocalization.of(context).locale = Locale('hi', 'IN');
    }
    flag = !flag;
    //on every click this flag value must change
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('msg2')),
      ),
      body: Column(
        children: [
          Text(tr('msg1')),//::::::instead of 'string' use tr('string')
          Divider(height: 10),
          RaisedButton(
              onPressed: () {
                _changeLang();
              },
              child: Text('Change Language')),
        ],
      ),
    );
  }
}
