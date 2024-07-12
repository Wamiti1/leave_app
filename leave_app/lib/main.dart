import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
// import 'package:leave_app/screens/leavescreen.dart';
import 'package:leave_app/screens/login.dart';
// Map<String, String> results = {
//                   'firstname': 'David',
//                   'lastname': 'Wamiti',
//                   'email': 'david@gmail.com',
//                   'password': 'hello32'
//                 };

void main() {
  runApp(MaterialApp(
    title: 'Leave App',
    debugShowCheckedModeBanner: false,    
    theme: FlexThemeData.light(scheme: FlexScheme.hippieBlue,),
    darkTheme: FlexThemeData.dark(scheme: FlexScheme.hippieBlue, darkIsTrueBlack: true),
    home:  const Login(),
  ));
}


