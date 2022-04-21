import 'package:flutter/material.dart';
import 'package:girl_hackathon/common/Colors_App.dart';

import '../app_theme.dart';

Widget homeCards(BuildContext context, String image, String title,
    Function onPressed, bool isDown) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  return Card(
      margin: EdgeInsets.only(
          top: (isDown) ? height * 0.04 : height * 0.01, bottom: height * 0.01),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: new Column(children: [
        Material(
          child: InkWell(
            onTap: () {
              onPressed();
            },
            child: Ink(
                width: width * 0.42,
                height: height * 0.26,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0)),
                ),
                child: Container(
                  margin: EdgeInsets.all(width * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        image,
                        height: 0.12 * height,
                        width: 0.15 * height,
                        color: AppTheme.blue,
                        alignment: Alignment.topCenter,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: height * 0.026,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ]));
}

Widget appBar(String name) {
  return Container(
    color: AppTheme.blue,
    height: AppBar().preferredSize.height,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 8),
          child: Container(
            width: AppBar().preferredSize.height - 8,
            height: AppBar().preferredSize.height - 8,
          ),
        ),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 20,
                  color: AppTheme.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, right: 8),
          child: Container(
            width: AppBar().preferredSize.height - 8,
            height: AppBar().preferredSize.height - 8,
            color: AppTheme.blue,
            // child: Material(
            //   color: Colors.transparent,
            //   child: InkWell(
            //     borderRadius:
            //     BorderRadius.circular(AppBar().preferredSize.height),
            //     child: Icon(
            //       multiple ? Icons.dashboard : Icons.view_agenda,
            //       color: AppTheme.dark_grey,
            //     ),
            //     onTap: () {
            //       setState(() {
            //         multiple = !multiple;
            //       });
            //     },
            //   ),
            // ),
          ),
        ),
      ],
    ),
  );
}

Widget getCarouselIndicator(int _current, List PostersList) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: PostersList.map((url) {
      int index = PostersList.indexOf(url);
      return Container(
        width: 8.0,
        height: 8.0,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _current == index ? AppTheme.blue : Color(0xFFD6E0F0),
        ),
      );
    }).toList(),
  );
}
