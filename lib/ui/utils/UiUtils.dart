
import 'package:anime_app/ui/component/TitleHeaderWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UiUtils {

  static Widget appTitleWidget() => const TitleHeaderWidget(
      iconData: Icons.video_library,
      title: 'AnimeApp'
  );

  static Widget getAppIcon({double size}) =>
    SvgPicture.asset(
      'assets/icons/anistore.svg',
          color: Colors.white,
          width: size ?? 32,
          height: size ?? 32,
    );
}