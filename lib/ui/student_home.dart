import 'package:flutter/material.dart';
import 'package:girl_hackathon/common/CommonWidgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:girl_hackathon/ui/video_tutorial.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_theme.dart';
import '../loading.dart';

class student_home extends StatefulWidget {
  @override
  _student_homeState createState() => _student_homeState();
}

class _student_homeState extends State<student_home> {
  // FireBaseHelper fb = new FireBaseHelper();
  String link =
      "https://firebasestorage.googleapis.com/v0/b/girlhackathon-cdf1c.appspot.com/o/icons%20glossary.pdf?alt=media&token=22d2eb52-df67-4210-9465-999c311a4778";
  bool flag = true;
  List images = [
    'lib/images/book_session.png',
    '',
    'lib/images/community.png',
    'lib/images/video_tutorial.png',
    'lib/images/notes.png',
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return (flag)
        ? Container(
            color: AppTheme.nearlyWhite,
            child: SafeArea(
              top: false,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    appBar("HOME"),
                    // Container(
                    //   padding: EdgeInsets.only(
                    //       top: MediaQuery.of(context).padding.top,
                    //       left: 16,
                    //       right: 16),
                    //   child: Text(""),
                    // ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, bottom: 10),
                      child: Text(
                        'UPCOMING EVENTS',
                        style: TextStyle(
                          color: AppTheme.dark_grey,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, bottom: 10),
                      child: Text(
                        'No upcoming events!',
                        style: TextStyle(
                          color: AppTheme.dark_grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, bottom: 10),
                      child: Text(
                        'YOUR ACTIVITIES',
                        style: TextStyle(
                          color: AppTheme.dark_grey,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    StaggeredGridView.countBuilder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.all(10),
                      crossAxisCount: 2,
                      itemCount: 5,
                      crossAxisSpacing: 0.02 * width,
                      mainAxisSpacing: 0.02 * width,
                      itemBuilder: (context, index) {
                        return index == 1
                            ? Container(
                                child: Text(''),
                              )
                            : Column(
                                children: [
                                  InkWell(
                                    child: Card(
                                      elevation: 1,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              0.041 * width)),
                                      child: Container(
                                        width: width * 0.5,
                                        padding: EdgeInsets.all(0.5 * height),
                                        height: 0.22 * height,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              0.015 * height),
                                          image: DecorationImage(
                                            image: AssetImage(images[index]),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[],
                                        ),
                                      ),
                                    ),
                                    onTap: () async {
                                      if (index == 3) {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  VideoTutorial()),
                                        );
                                      }
                                      if (index == 4) {
                                        String url = link;
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      }
                                      if (index == 0) {
                                        String url =
                                            "https://calendar.google.com/";
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      }
                                    },
                                  ),
                                  // Container(
                                  //   padding: EdgeInsets.only(
                                  //     left: 0.025 * width,
                                  //   ),
                                  //   child: Text(eventss[index].name,
                                  //       style: tc.home()),
                                  //   alignment: Alignment.bottomLeft,
                                  // ),
                                ],
                              );
                      },
                      staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Loading();
  }
}
