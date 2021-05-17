import 'dart:ui';

import 'package:brewcrew/shared/constants.dart';
import 'package:flutter/material.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formkey = GlobalKey<FormState>();

  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values this are the values which we will slect after the values get selected from form
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
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
              decoration: textInputDecoration,
              validator: (val) => val.isEmpty ? 'Please enter a name' : null,
              onChanged: (val) => setState(() => _currentName = val),
            ),
            SizedBox(
              height: 10.0,
            ),
            // dropdown list for selecting sugars
            DropdownButtonFormField(
              items: sugars.map((sugar) {
                return DropdownMenuItem(
                  value: sugar,
                  child: Text('$sugar sugars'),
                );
              }).toList(),
              onChanged: (val)=>setState(()=>_currentSugars = val),
            ),

            // slider
            //UPDATE BUTTON
            ElevatedButton(
                onPressed: () {},
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
  }
}
