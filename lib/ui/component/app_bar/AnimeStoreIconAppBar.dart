import 'package:anime_app/ui/theme/ColorValues.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimeStoreIconAppBar extends StatelessWidget with PreferredSizeWidget {
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: Container(),
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SvgPicture.asset(
                'assets/icons/anistore.svg',
                  color: Colors.white,
                  width: 32,
                  height: 32,
              ),
              Container(
                margin: EdgeInsets.only(left: 12.0),
                child: Text('Anime Store')
              ),
            ],
          ),
        ),
      );
  }

  @override
  
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  }