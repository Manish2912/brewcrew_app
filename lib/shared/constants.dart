import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
    // hintText: 'Enter ur email',// thsi is harcoded string we want to change the
    // the hint text for every field so we will use copywith()
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2.0)),
    // this is to border text when we ate writting something
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pink, width: 2.0)));
