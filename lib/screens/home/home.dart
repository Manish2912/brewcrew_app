import 'package:brewcrew/models/brew.dart';
import 'package:brewcrew/screens/home/settting_form.dart';
import 'package:brewcrew/services/auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brewcrew/services/database.dart';
import 'package:brewcrew/screens/home/brew_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  // here we r creating object of AuthService

  @override
  Widget build(BuildContext context) {
    // deffining a function for showing models ie list perference
    void _showSettingPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      // now we can use ther snapshot of data available
      // and provide this data to all the wrapped users
      // initialData: null,
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[500],
          title: Text('Brew Crew'),
          elevation: 0.0,
          actions: [
            ElevatedButton.icon(
              onPressed: () async {
                await _auth.signOut();
                // calling signOut() function of defined in AuthService()
                // using object created in this class
              },
              icon: Icon(Icons.person),
              label: Text('LogOut'),
            ),
            ElevatedButton.icon(
                onPressed: () => _showSettingPanel(),
                icon: Icon(Icons.settings),
                label: Text('Settings'))
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
