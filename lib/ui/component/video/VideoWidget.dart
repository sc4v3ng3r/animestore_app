import 'package:anime_app/i18n/AnimeStoreLocalization.dart';
import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/logic/stores/video_player_store/VideoPlayerStore.dart';
import 'package:anime_app/ui/theme/ColorValues.dart';
import 'package:anime_app/ui/utils/UiUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

/// TODO:
/// * implement awake lock [DONE]
/// * next episode navigation
/// * previous episode navigation
/// * auto play
/// * auto episode navigation
/// * exit button
/// * Aspect ratio button
///

class VideoWidget extends StatefulWidget {
  final String episodeId;

  const VideoWidget({Key key, @required this.episodeId}) : super(key: key);
  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

enum _MenuOption { NEXT, PREVIOUS, EXIT }

class _VideoWidgetState extends State<VideoWidget>
    with TickerProviderStateMixin {
  VideoPlayerController videoController;
  AnimationController controller;

  Animation topDownTransition, downTopTransition;
  Animation opacityAnimation;

  VideoPlayerStore videoPlayerStore;
  ApplicationStore appStore;
  static const _DEFAULT_ASPECT_RATIO = 3 / 2;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    Wakelock.enable();
    super.initState();

    appStore = Provider.of<ApplicationStore>(context, listen: false);
    videoPlayerStore = VideoPlayerStore(appStore);
    videoPlayerStore.loadEpisodeDetails(widget.episodeId);

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 450),
    );

    topDownTransition = Tween<Offset>(begin: Offset(.0, -50), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: controller,
            curve: Curves.fastLinearToSlowEaseIn,
            reverseCurve: Curves.fastLinearToSlowEaseIn));

    downTopTransition = Tween<Offset>(begin: Offset(.0, 50), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: controller,
            curve: Curves.fastLinearToSlowEaseIn,
            reverseCurve: Curves.fastLinearToSlowEaseIn));

    opacityAnimation = Tween<double>(begin: .0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: Curves.easeIn,
            reverseCurve: Curves.easeIn));
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    controller?.dispose();
    videoPlayerStore.dispose();
    Wakelock.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: WillPopScope(
        onWillPop: () async {
          if (videoPlayerStore.episodeLoadingStatus ==
              EpisodeStatus.DOWNLOADING)
            videoPlayerStore.cancelEpisodeLoading();

          await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
          await SystemChrome.setPreferredOrientations(
              [DeviceOrientation.portraitUp]);
          // after orientation changes the controller is playing
          // the video again due build method fired again.
          return true;
        },
        child: Container(
          width: size.width,
          height: size.height,
          color: Colors.transparent,
          child: Observer(
            builder: (_) {
              Widget widget;

              switch (videoPlayerStore.episodeLoadingStatus) {
                case EpisodeStatus.BUFFERING:
                case EpisodeStatus.DOWNLOADING:
                  widget = buildLoaderWidget();
                  break;

                case EpisodeStatus.DOWNLOADING_DONE:
                  widget = buildLoaderWidget();
                  break;

                case EpisodeStatus.CANCELED:
                  widget = Container();
                  break;

                case EpisodeStatus.ERROR:
                  widget = buildErrorWidget();
                  break;

                case EpisodeStatus.READY:
                  videoController = videoPlayerStore.controller;
                  widget = buildPlayerWidget(size);
                  //videoPlayerStore.playOrPause();
                  controller.forward();
                  break;
              }
              return widget;
            },
          ),
        ),
      ),
    );
  }

  Widget buildPlayerWidget(final Size size) => GestureDetector(
        onTap: () {
          if (controller.isCompleted) {
            controller.reverse();
          } else {
            controller.forward();
          }
        },
        child: Container(
          width: size.width,
          height: size.height,
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: AspectRatio(
                  aspectRatio: _DEFAULT_ASPECT_RATIO,
                  child: VideoPlayer(videoController),
                ),
              ),
              AnimatedBuilder(
                animation: controller,
                builder: (_, __) => SlideTransition(
                  position: topDownTransition,
                  child: buildTopWidget(size),
                ),
              ),
              AnimatedBuilder(
                  animation: controller,
                  builder: (_, __) => FadeTransition(
                        opacity: opacityAnimation,
                        child: buildCenterControllersWidget(
                            size, controller.isCompleted),
                      )),
              AnimatedBuilder(
                animation: controller,
                builder: (_, __) => SlideTransition(
                  position: downTopTransition,
                  child: buildBottomWidget(size),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildLoaderWidget() => Center(
        child: CircularProgressIndicator(),
      );

  Widget buildTopWidget(final Size size) => Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: size.width,
          height: 100,
          color: Colors.transparent,
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: .0,
            centerTitle: true,
            leading: Container(),
            actions: <Widget>[
              IconButton(
                padding: EdgeInsets.only(right: 8.0),
                // iconSize: 25,
                onPressed: () {
                  showMenu(
                    elevation: .0,
                    position: RelativeRect.fromLTRB(100, 50, 0, 0),
                    color: Colors.transparent,
                    context: context,
                    items: popupMenuItems( AnimeStoreLocalization.of(context) ),
                  );
                },
                color: Colors.white,
                icon: Icon(
                  Icons.more_vert,
                ),
              ),
            ],
            title: Container(
              width: size.width,
              height: 100,
              child: Text(
                videoPlayerStore.currentEpisode.title,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      );

  Widget buildCenterControllersWidget(final Size size, bool available) => Align(
        alignment: Alignment.center,
        child: Container(
          width: size.width,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                disabledColor: Colors.white,
                color: Colors.white,
                iconSize: 65.0,
                icon: Icon(
                  Icons.replay_10,
                ),
                onPressed: available
                    ? () => videoPlayerStore
                        .seekTo(videoPlayerStore.currentPosition.inSeconds - 10)
                    : null,
              ),
              IconButton(
                disabledColor: Colors.white,
                color: Colors.white,
                iconSize: 100,
                icon: Observer(
                  builder: (_) {
                    var icon = videoPlayerStore.isPlaying
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outline;
                    return Icon(
                      icon,
                    );
                  },
                ),
                onPressed:
                    available ? () => videoPlayerStore.playOrPause() : null,
              ),
              IconButton(
                disabledColor: Colors.white,
                iconSize: 65.0,
                color: Colors.white,
                icon: Icon(
                  Icons.forward_10,
                ),
                onPressed: available
                    ? () => videoPlayerStore
                        .seekTo(videoPlayerStore.currentPosition.inSeconds + 10)
                    : null,
              ),
            ],
          ),
        ),
      );

  Widget buildBottomWidget(final Size size) => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: size.width,
          height: 80,
          color: Colors.transparent,
          child: Observer(
            builder: (_) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SliderTheme(
                    data: SliderThemeData(
                      thumbColor: accentColor,
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 7,
                      ),
                    ),
                    child: Container(
                      height: 30,
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      child: Slider(
                        activeColor: accentColor,
                        value: videoPlayerStore.currentPosition.inSeconds
                            .toDouble(),
                        min: .0,
                        max: videoPlayerStore
                            .controller.value.duration.inSeconds
                            .toDouble(),
                        onChanged: (value) =>
                            videoPlayerStore.seekTo(value.toInt()),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 24.0, bottom: 8.0),
                      child: Text(
                        "${_printDuration(videoPlayerStore.currentPosition)}" +
                            " / ${_printDuration(videoPlayerStore.controller.value.duration)}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      );

  String _printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes);
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  Widget buildErrorWidget() => Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Icon(
            Icons.error,
            color: Colors.red,
            size: 82,
          )),
          Container(
            height: 10,
          ),
          Text(
            'Vídeo Indisponível..',
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
                color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          RaisedButton(
            child: Text('Voltar'),
            onPressed: () => Navigator.pop(context),
          )
        ],
      );

  //value, title, icon
  List<Widget> popupMenuItems(AnimeStoreLocalization locale) {
    var widgetList = <PopupMenuItem<_MenuOption>>[];

    if (videoPlayerStore.currentEpisode.previousEpisodeId.isNotEmpty)
      widgetList.add(
        UiUtils.createMenuItem<_MenuOption>(
          icon: Icon(Icons.skip_previous,color: Colors.white,),
          value: _MenuOption.PREVIOUS,
          title: locale.previous,
        )
      );

    if (videoPlayerStore.currentEpisode.nextEpisodeId.isNotEmpty)
      widgetList.add(
        UiUtils.createMenuItem<_MenuOption>(
          icon: Icon(Icons.skip_next, color: Colors.white,),
          value: _MenuOption.NEXT,
          title: locale.next,
        )
      );

    widgetList.add(
      UiUtils.createMenuItem(
        icon: Icon(Icons.exit_to_app, color: Colors.white,),
          value: _MenuOption.EXIT,
          title: locale.quit,
      )
    );
    return widgetList;
  }
}
