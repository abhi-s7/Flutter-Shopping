import 'dart:async';

import 'package:flipkartClone/screens/home_screen.dart';
import 'package:flipkartClone/utils/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  //1
  //with is used to inherit the multiple classes as Flutter doesnot provide such feature with extends
  AnimationController _animationController; //2 - syncing and setting up the animation
  Animation _animation; //3 - what sort of animation we want to have 

  void _doAnimations() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
        //it is responsible to sync the animation with the widget therefore there is attribute vsync
        //vsync is then responsibilty of ticker and it is inherited by our widget SplashScreen therefore it have ticker as well as widget feature
        //vsync: this - it tell that this application will manage the application and understand the frame rate
        //Therefore SingleTickerProviderStateMixin is required which sync the state of animation one after the another - one frame to another frame and it is only possible with this Ticker class 

    //does the start stop i.e. controls the animations
    _animation = CurvedAnimation(
      //it is not pre defined applied on the widgets we are invoking it thus it is custom animation
        parent: _animationController,//as it is controlled by _animationController
        curve: Curves.bounceInOut); //it will have bouncing effect

    //now building it as it must be re-render on the screen
    _animation.addListener(() {
      setState(() {});//this way animation effect automatically comes into picture
    });
    _animationController
        .forward(); //one after the another effect will take place [forwarding the frames]
    //More the animations more the CPU power required

    _moveToNextScreen(); //move to next screen after animation of some duration
  }

  _moveToNextScreen() {
    Timer(
      Duration(seconds: 5),
      () => Navigator.of(context).pushReplacementNamed(Constant.HOME_ROUTE),
      //pushReplacementNamed - this means we are giving names to the routes to make routing not just one screen to another
    );
    /*
    //it requires 'dart:async'
    Timer(
        Duration(seconds: 5),
        () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => HomeScreen(),
            )));
    */
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _doAnimations();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //life cycle method
    //it will automatically called when moved to the next screen
    //so good practice is to dispose the animation when screen has been moved
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(Constant.FLIPKART_BLUE),
      body: Stack(
        fit: StackFit.expand, //this will take the whole application side
        //when content size is small then Stack Size is also small
        children: [
          //either use position widgets but it won't be response
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize
                .min, //otherwise it would take whole the screen and we want to allocate the minimum space to it's children
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Text(
                  Constant.POWERED_BY,
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              )
            ],
          ),
          //using column to center the image vertically
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Constant.FLIPKART_LOGO,
                width: _animation.value * 250,
                height: _animation.value * 250,
              )
            ],
          ),
        ],
      ),
    );
  }
}
/*
2 type of animations
1. Tween (two things) Based - executes b/w two values. they have a starting points and ending points
  -from one state to another

2. Physics based - Relates to the real world animation. eg. jump, fall or swinging with gravity
                - respond to the user input


How to create Animation - two ways

Implicit & Explicit animations

I. Implicit - Pre built widgets which provide you some kind of animation

II. Explicit - Building/Creating own custom animations

  3 pillars required for an explicit animation :-
    1. Ticker 
      - sprite sheet 
      - run frame by frame 
      - attatchs/provides a callback

    2. Animation Controller 
      - start, stop, resume, reverse 
      - manager

    3. Animation class 
      - start & end cycle


*/
