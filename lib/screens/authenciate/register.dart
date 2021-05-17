import 'package:brewcrew/services/auth.dart';
import 'package:brewcrew/shared/constants.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function
      toggleView; // since we r pasing this in widget so we will pass this
  // in stateful widget
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = '';
  String password =
      ''; // don't keep string value null if we want to diaplay string
  // through text
  String error = '';

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  // we r keeping a check on the form via _formKey
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign Up to Brew Crew'),
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('SignIn'))
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
              key:
                  _formKey, // we can change the state and do validation of form via this key

              child: Column(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  // this is for email
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Enter ur Email'),

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
                  TextButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          // here we r checking the current state
                          // validation by using formKey it bascially returns true or false
                          // this validate function can check validation by applying validator on text field
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
                          // calling Registerinwithemail funcytion using _auth object of AuthService()
                          // and passing email and password

                          if (result == null) {
                            // if the user has not properly entered a proper email
                            // then the result will be null and we will ask the user to enter
                            // a proper email this is done using setState()

                            setState(() {
                              error = ' please supply a proper email';
                              loading = false;
                            });
                          }
                        }
                      },
                      child: Text(
                        'REGISTER IN',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.pink,
                      )),
                  // printing error msg after invalid registration
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
