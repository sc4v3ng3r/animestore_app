import 'package:anime_app/ui/component/TitleHeaderWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:anime_app/ui/component/DotSpinner.dart';

class UiUtils {
  static Widget appTitleWidget() => const TitleHeaderWidget(
        iconData: Icons.video_library,
        title: 'AnimeApp',
      );

  static Widget getAppIcon({double? size}) => SvgPicture.asset(
        'assets/icons/anistore.svg',
        color: Colors.white,
        width: size ?? 32,
        height: size ?? 32,
      );

  static Widget centredDotLoader() => Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DotSpinner(),
        ],
      );
  static PopupMenuItem<T> createMenuItem<T>(
      {required T value, required String title, required Icon icon}) {
    return PopupMenuItem<T>(
      value: value,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(margin: const EdgeInsets.only(right: 8.0), child: icon),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
