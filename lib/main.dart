// import 'dart:html';

import 'package:brewcrew/models/user.dart';
import 'package:brewcrew/screens/wrapper.dart';
import 'package:brewcrew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // this streamProvide is used to provide the user authenciation information
    //to all the bneath classes espacially the wrapper class
    return StreamProvider<User>.value (
  // here we r creating instance of AuthService and then calling user function
  //to pass user stream data ("Which will be sign in information") to all the descent classes   
  // <User> specify that we r passing the state of User object which is requires
  // if user sign in it will pass UserObject and if it will signOut then we will pass Null
   
  value: AuthService().user,
          child: MaterialApp(
        home:Wrapper(), // now we can listen for user authen information  inside wrapper class
      ),
    );
  }
}

