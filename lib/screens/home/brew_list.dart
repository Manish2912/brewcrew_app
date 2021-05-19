import 'package:brewcrew/models/brew.dart';
import 'package:brewcrew/screens/home/brew_tile.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context) ??[];
    // here we r creating a variable for going through the list of data that is
    // available to us
    // mainly list of users and their data
    
// creating a list in the home page
    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context,index)
      {
        return BrewTile(brew:brews[index]);  // in order to use this list view 
                                   // anywhere in the function we will crete a class and use its object
      }     //brews[index] are list of objects Brew
    );
  }
}
