import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/ui/theme/ColorValues.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

        SvgPicture.asset(
          'assets/icons/anistore.svg',
          color: Colors.white,
          width: 120,
          height: 120,
        ),

          Container(
            margin: EdgeInsets.only(top: 16),
            child: Text('Anime Store',
              style: TextStyle(
                color: textPrimaryColor,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 32
              ),
            ),
          ),
        ],
      ),
    );
  }
}
