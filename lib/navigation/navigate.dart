
import 'package:flutter/material.dart';
import 'package:girl_hackathon/components/phone_auth_form.dart';
import 'package:girl_hackathon/ui/home.dart';
import 'package:girl_hackathon/ui/login.dart';
import 'package:girl_hackathon/ui/navigationbase.dart';
import 'package:girl_hackathon/ui/welcome.dart';
import 'package:girl_hackathon/ui/wrapper.dart';




class Navigate {
  static Map<String, Widget Function(BuildContext)> routes =   {
    '/sign-in' : (context) => SignInPage(),
    '/home'  : (context) => NavigationHomeScreen(),
    '/verify-otp' : (context) => PhoneAuthForm()
  };
}