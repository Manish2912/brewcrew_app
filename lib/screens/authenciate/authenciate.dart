import 'package:brewcrew/screens/authenciate/register.dart';
import 'package:brewcrew/screens/authenciate/sign-in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showsignIn = true;

  // this is function which we will used for  toggling

  void toggleView() {
    setState(() => showsignIn = !showsignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showsignIn)
      return SignIn(
          toggleView: toggleView); // since we need to use this function
    // in our SignIn and register page so we will pass
    // this functions as parameters and use this functions there
    else // parameter name: function name
      return (Register(toggleView: toggleView));
  } // since we passing this function in  widget
  // so we need to create this constructor in widget only but we
  // can use it in State also

}

// so wheen oue app starts our signIn will be true;

// then signIN page appears at first, when we click register button
// then toogleview function is called and Signin value becomes false
//and Register page is opened 