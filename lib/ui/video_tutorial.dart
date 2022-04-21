// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:girl_hackathon/common/CommonWidgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_theme.dart';

class VideoTutorial extends StatefulWidget {
  @override
  _VideoTutorial createState() => _VideoTutorial();
}

class _VideoTutorial extends State<VideoTutorial> {
  @override
  Widget build(BuildContext context) {
    List<String> name = [
      'Whatsapp Tutorial',
      'Smart Phone Basics(Android)',
      'Smart Phone Basics(IPhone)'
    ];
    List<String> link = [
      'https://www.youtube.com/watch?v=1B-u8AS34Bw&ab_channel=Outsourcedatacaptureservices',
      'https://www.youtube.com/watch?v=r22jFymPxRY&ab_channel=CouncilforThirdAge',
      'https://www.youtube.com/watch?v=9cY6OyHUEdA&ab_channel=RichBowlin'
    ];
    List<String> thumb = [
      'lib/images/whatsapp.jpg',
      'lib/images/basics_android.jpeg',
      'lib/images/basics_iphone.jpg'
    ];
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return (new Scaffold(
        body: Container(
      height: height,
      child: Column(
        children: [
          Container(
            color: AppTheme.blue,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: height * 0.04,
                  ),
                ),
                SizedBox(
                  width: width * 0.25,
                ),
                Container(
                  child: Text(
                    "Video Tutorials",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: height * 0.03,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          new ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.all(0.03 * height),
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: InkWell(
                  onTap: () async {
                    String url = link[index];
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch  $url';
                    }
                  },
                  child: (new Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0102 * height),
                      ),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0.0102 * height),
                              topRight: Radius.circular(0.0102 * height),
                            ),
                            child: Image.asset(thumb[index],
                                height: 0.20 * height, fit: BoxFit.fitWidth),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 0.05 * width,
                                top: 0.0102 * height,
                                bottom: 0.0102 * height),
                            child: Text(
                              name[index],
                              style: TextStyle(
                                color: AppTheme.dark_grey,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ))),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: 0.006 * height,
            ),
          ),
        ],
      ),
    )));
  }
}
