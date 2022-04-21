//import 'dart:html';

import 'package:girl_hackathon/drawer/drawer_controller.dart';
import 'package:girl_hackathon/drawer/home_drawer.dart';
import 'package:girl_hackathon/ui/student_home.dart';

import 'package:flutter/material.dart';

import '../app_theme.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  late Widget screenView;
  late DrawerIndex drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = student_home();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = student_home();
        });
      } else if (drawerIndex == DrawerIndex.Settings) {
        setState(() {
          screenView = student_home();
        });
      } else if (drawerIndex == DrawerIndex.Help) {
        setState(() {
          screenView = student_home();
        });
      } else if (drawerIndex == DrawerIndex.AboutUs) {
        setState(() {
          screenView = student_home();
        });
      } else {
        //do in your way......
      }
    }
  }
}
