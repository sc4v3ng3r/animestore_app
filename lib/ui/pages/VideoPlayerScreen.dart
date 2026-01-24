import 'package:anime_app/ui/component/video/VideoWidget.dart';
import 'package:flutter/material.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String episodeUri;

  const VideoPlayerScreen({Key? key, required this.episodeUri})
      : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  @override
  Widget build(BuildContext context) => VideoWidget(
        episodeUri: widget.episodeUri,
      );
}
