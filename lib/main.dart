import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:girl_hackathon/services/auth.dart';
import 'package:girl_hackathon/ui/wrapper.dart';
import 'package:provider/provider.dart';

import 'navigation/navigate.dart';
import 'utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Firebase.initializeApp();
  runApp(
    StreamProvider<User?>.value(
      value: AuthService().user,
      initialData: FirebaseAuth.instance.currentUser,
      child: MaterialApp(
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          routes: Navigate.routes,
          title: "Girl Hackathon",
          color: Colors.black,
          home: SafeArea(child: Wrapper())),
    ),
  );
}
