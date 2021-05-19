import 'dart:ui';

import 'package:brewcrew/models/user.dart';
import 'package:brewcrew/services/database.dart';
import 'package:brewcrew/shared/constants.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formkey = GlobalKey<FormState>();

  final List<String> sugars = ['0', '1', '2', '3', '4'];
  final List<int> strengths = [100, 200, 300, 400, 500, 600, 700, 800, 900];

  // form values this are the values which we will slect after the values get selected from form
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          // snaphot= this snapshot refers to data coming from the stream not from the firebase
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            // storing snapshot data in the userdata

            return Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Update your brew seeting',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 20.0),
                    // TextFormField for sugars
                    TextFormField(
                      initialValue: userData.name,
                      decoration: textInputDecoration,
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    // dropdown list for selecting sugars
                    DropdownButtonFormField(
                      decoration: textInputDecoration,
                      value: _currentSugars ??
                          // storing thye default value of sugars
                          userData.sugars, // this is value to de displayed
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          value:
                              sugar, // this is value that wil appear in the drop downlist

                          child: Text('$sugar sugars'),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentSugars = val),
                    ),

                    // slider
                    Slider(
                      value: (_currentStrength ?? 100).toDouble(),
                      activeColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      inactiveColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      min: 100.0,
                      max: 900.0,
                      divisions: 8,
                      onChanged: (val) =>
                          setState(() => _currentStrength = val.round()),
                    ),
                    //UPDATE BUTTON
                    ElevatedButton(
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            await DatabaseService(uid: user.uid).updateUserData(
                                _currentSugars ?? userData.sugars,
                                _currentName ?? userData.name,
                                _currentStrength ?? userData.strength);
                            Navigator.pop(context);// poping out bottom sheets 
                          }
                        },
                        child: Text(
                          'Update',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ))
                  ],
                ),
              ),
            );
          } else {
            return Loading(); // this is when snapshot has no data it will load
          }
        });
  }
}
