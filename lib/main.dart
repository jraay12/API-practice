import 'package:api/formpage.dart';
import 'package:api/homepage.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue
    ),
    home: Homepage(),
  ));
}