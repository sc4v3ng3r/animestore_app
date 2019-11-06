import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/ui/theme/ColorValues.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<ApplicationStore>(context).initApp();

    return Material(
      color: primaryColor,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Icon(Icons.video_library, color: textPrimaryColor,
            size: 120,
          ),
          Text('AnimeApp',
            style: TextStyle(
              color: textPrimaryColor,
              fontSize: 32
            ),
          ),
        ],
      ),
    );
  }
}
