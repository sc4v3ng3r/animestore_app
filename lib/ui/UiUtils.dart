
import 'package:flutter/material.dart';

class UiUtils {

  static Widget appTitleWidget() => createAppBarTitleWidget(
    iconData: Icons.video_library,
    title: 'AnimeApp'
  );

  static Widget createAppBarTitleWidget({@required IconData iconData,
    String title,
    TextStyle style,
    Color iconColor,
    String heroTag}) =>
      Hero(
        tag: heroTag ?? UniqueKey().toString(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              iconData,
              color: iconColor,
            ),
            Container(
              width: 4.0,
            ),
            Text('$title', style: style,),
          ],
        ),
      );

}