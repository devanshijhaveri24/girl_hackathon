
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:girl_hackathon/components/phone_auth_form.dart';
import 'package:girl_hackathon/ui/home.dart';
import 'package:girl_hackathon/ui/navigationbase.dart';
import 'package:girl_hackathon/ui/student_home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

   final user =Provider.of<User?>(context);

   if(user==null){
     return PhoneAuthForm();
   } else{
     return NavigationHomeScreen();
   }
  }

}
