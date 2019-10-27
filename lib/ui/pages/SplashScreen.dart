import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Provider.of<ApplicationStore>(context).initApp();

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
