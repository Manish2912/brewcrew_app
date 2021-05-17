import 'package:brewcrew/services/auth.dart';
import 'package:brewcrew/shared/constants.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = '';
  String password = '';
  String error = '';

  final AuthService _auth = AuthService();
// here we r creating object of AuthService class so that we can use it s fuction
// defined in AuthService class
  final _formKey = GlobalKey<FormState>();
  // we r keeping a check on the form via _formKey
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    // when loading is true we will show loading screen otherwise we will be in the image
    return loading?Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Brew Crew'),
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                widget.toggleView();
                // we used widget not this becoz we have defined our constructor
                // in the widget class so accessing using widget
              },
              icon: Icon(Icons.person),
              label: Text('Registar'))
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
              key: _formKey, // adding _formkey to our form
              child: Column(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  // this is for email
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Enter ur email'),
                    validator: (val) => val.isEmpty
                        ? 'Enter an Email '
                        : null, // if the form val is empty then
                    // we will pass a helper string to ask user to enter a email and not keep it null
                    onChanged: (val) {
                      setState(() => {
                            email =
                                val // putting the value entered in val as email
                            // this is like intialzing the value of email with the
                            // value entered in email
                          });
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  // this is for password

                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Enter ur password'),
                    validator: (val) => val.length < 6
                        ? 'Enter a password of 6 chars long'
                        : null,
                    obscureText: true, // this is used for hiding password
                    onChanged: (val) {
                      // this is for password what we have done for email
                      setState(() => {password = val});
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  // sign in button
                  TextButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          // this setState() is fore loading screen we r seeting true when user is valid
                          setState(() =>loading=true);
                          // here we r checking the current state
                          // validation by using formKey it bascially returns true or false
                          // this validate function can check validation by applying validator on text field
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          // calling signinwithemail funcytion using _auth object of AuthService()
                          // and passing email and password

                          if (result == null) {
                            // if the user has not properly entered a proper email
                            // then the result will be null and we will ask the user to enter
                            // a proper email this is done using setState()

                            setState(() { error =
                                'could not sign in with that credentials';
                              loading=false; // putting loading screen to be false when thre is null value
                          });
                        }
                        }},
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(color: Colors.white)),
                 
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.pink,
                      )),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  )
                ],
              ))),
    );
  }
}
