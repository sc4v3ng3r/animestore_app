import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/logic/stores/video_player_store/VideoPlayerStore.dart';
import 'package:anime_app/ui/component/video/VideoWidget.dart';
import 'package:flutter/material.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String episodeId;

  const VideoPlayerScreen({Key key, this.episodeId})
      : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}


class _VideoPlayerScreenState extends State<VideoPlayerScreen> {

  ApplicationStore appStore;
  VideoPlayerStore videoPlayerStore;

  @override
  Widget build(BuildContext context) =>
    VideoWidget(episodeId: widget.episodeId,);
}