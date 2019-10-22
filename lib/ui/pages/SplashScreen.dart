import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Icon(Icons.video_library, color: Colors.white,
            size: 120,
          ),
          Text('AnimeApp',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32
            ),
          ),
        ],
      ),
    );
  }
}
