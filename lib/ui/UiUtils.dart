
import 'package:anime_app/ui/component/TitleHeaderWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UiUtils {

  static Widget appTitleWidget() => const TitleHeaderWidget(
      iconData: Icons.video_library,
      title: 'AnimeApp'
  );
}