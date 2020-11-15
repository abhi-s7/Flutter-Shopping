import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MicDemo extends StatefulWidget {
  @override
  _MicDemoState createState() => _MicDemoState();
}

class _MicDemoState extends State<MicDemo> {

  //:::::::::::::::::::::Speech to Text:::::::::::::::::::::::::::::

  //:::::::Permission Required::::::::::::::::
  //1. android.permission.RECORD_AUDIO 2. android.permission.INTERNET
  String msg = '';
  void _speakNow() async {
    // from package - speech_to_text
    // 1. First create an object of speech to text
    SpeechToText speechToText = SpeechToText();

    // 2.1 initialize this
    bool isReady = await speechToText.initialize(
        onError: errorListener, onStatus: successListener);
    //onStatus gives a parameter of String
    // onError gives a parameter of SpeechRecognitionError
    // speechToText gives future of bool

    /*2.2 based on initialization it will give either 
         a. Error - arg(SpeechRecognitionError) which will contain the error message
         b. Status - arg(String of Status)

        It tells that app is allowed to access mic and listen or not
    */
    if (isReady) {
      msg = 'Device is Ready';
      //3.1 Now if the app is allowed to access mic then listen to it and give results based on it 
      speechToText.listen(onResult: speechResult);
      //onResult excepts a funtion(SpeechRecognitionResult)
    }
  }

  // Listener functions for SpeechToText
  void errorListener(SpeechRecognitionError status) {
    //don't import SpeechRecognitionError from dart:html
    setState(() {
      tc.text = status.errorMsg;
    });
  }

  successListener(String status) {
    setState(() {
      tc.text = status;
    });
  }

  //3.2 :::::: Result will be of type SpeechRecognitionResult
  // it's a class that give list of SpeechRecognitionWords
  speechResult(SpeechRecognitionResult result) {
    setState(() {
      msg = '${result.recognizedWords} ${result.finalResult}';
      //when speaking - recognizedWords - it's a getter method
      //When spoken and paused then - finalResult - boolean
      // it will be true if finished 
      tc.text = msg;
    });
  }
  //:::::::::::::::::::::::::::::::::::::::::::::::::::::

  //::::::::::::::::::::: Text to Speech :::::::::::::::::::::::::::::
  
  FlutterTts tts = FlutterTts();
  void readIt() async{
    String text = tc.text;
    await tts.setLanguage("en-US");//we can also have hindi language
    tts.setPitch(1);
    tts.speak(text);
  }

  TextEditingController tc =
      TextEditingController(); //to add the text to the TextField from mic

  @override
  Widget build(BuildContext context) {
    // to dynamically build anything use
    // body: Builder()
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              TextField(
                controller: tc,
                decoration: InputDecoration(hintText: 'Speak'),
                style: TextStyle(fontSize: 32),
              ), //for speech to texk
              RaisedButton(child: Text('Speack'), onPressed: (){
                readIt();
              },),
              RaisedButton(
                onPressed: () {
                  _speakNow();
                },
                child: Text('Mic'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
