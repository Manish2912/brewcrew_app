import 'package:brewcrew/models/user.dart';
import 'package:brewcrew/screens/authenciate/authenciate.dart';
import 'package:brewcrew/screens/home/home.dart';
//

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // here we r taking user object data and storing in user variable
    // by using provider
    //<User> shows that the result is User object

    if (user == null)
      return Authenticate();
    else
      return Home();
  }
}
