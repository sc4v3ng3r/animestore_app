import 'package:anime_app/generated/l10n.dart';
import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/logic/stores/video_player_store/VideoPlayerStore.dart';
import 'package:anime_app/ui/component/video/LoadingVideoWidget.dart';
import 'package:anime_app/ui/component/video/UnavailableVideoWidget.dart';
import 'package:anime_app/ui/theme/ColorValues.dart';
import 'package:anime_app/ui/utils/UiUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
// import 'package:video_player_header/video_player_header.dart';
// import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

/// TODO:
/// handle viewed episode if the anime is on user list.
/// * Aspect ratio button
/// *

class VideoWidget extends StatefulWidget {
  final String episodeId;

  const VideoWidget({Key key, @required this.episodeId}) : super(key: key);
  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

enum _MenuOption { NEXT, PREVIOUS, EXIT }

class _VideoWidgetState extends State<VideoWidget>
    with TickerProviderStateMixin {
  //VideoPlayerController videoController;
  AnimationController animationController;

  Animation topDownTransition, downTopTransition;
  Animation opacityAnimation;

  VideoPlayerStore videoPlayerStore;
  ApplicationStore appStore;
  S locale;

  static const _DEFAULT_ASPECT_RATIO = 3 / 2;
  static const _BACKGROUND_OPACITY_LEVEL = .5;

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

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 450),
    );

    topDownTransition = Tween<Offset>(begin: Offset(.0, -50), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: animationController,
            curve: Curves.fastLinearToSlowEaseIn,
            reverseCurve: Curves.fastLinearToSlowEaseIn));

    downTopTransition = Tween<Offset>(begin: Offset(.0, 50), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: animationController,
            curve: Curves.fastLinearToSlowEaseIn,
            reverseCurve: Curves.fastLinearToSlowEaseIn));

    opacityAnimation = Tween<double>(begin: .0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: Curves.easeIn,
            reverseCurve: Curves.easeIn));
  }

  @override
  void dispose() {
    animationController?.dispose();
    videoPlayerStore.dispose();
    Wakelock.disable();
    super.dispose();
  }

  Future<void> _prepareToLeave() async {
    if (videoPlayerStore.episodeLoadingStatus == EpisodeStatus.DOWNLOADING)
      videoPlayerStore.cancelEpisodeLoading();

    if (videoPlayerStore.isPlaying) await videoPlayerStore.controller.pause();

    await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    locale = S.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: WillPopScope(
        onWillPop: () async {
          await _prepareToLeave();
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
              Widget currentWidget;

              switch (videoPlayerStore.episodeLoadingStatus) {
                case EpisodeStatus.BUFFERING:
                case EpisodeStatus.DOWNLOADING_DONE:
                case EpisodeStatus.DOWNLOADING:
                  currentWidget = buildLoaderWidget();
                  break;

                case EpisodeStatus.CANCELED:
                  currentWidget = Container();
                  break;

                case EpisodeStatus.ERROR:
                  currentWidget = UnavailableVideoWidget(
                    retryCallback: () => videoPlayerStore.loadEpisodeDetails(
                      this.widget.episodeId,
                    ),
                    onBackCallback: () async {
                      await _prepareToLeave();
                      Navigator.pop(context);
                    },
                  );
                  break;

                case EpisodeStatus.READY:
                  currentWidget = buildPlayerWidget(size);
                  animationController.forward(from: .0);
                  break;
              }
              return currentWidget;
            },
          ),
        ),
      ),
    );
  }

  Widget buildPlayerWidget(final Size size) => GestureDetector(
        onTap: () {
          if (animationController.isCompleted) {
            animationController.reverse();
          } else {
            animationController.forward();
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
                  child: VideoPlayer(
                    videoPlayerStore.controller,
                  ),
                ),
              ),

              // here new widget

              Positioned.fill(
                child: AnimatedBuilder(
                  animation: animationController,
                  builder: (_, __) {
                    return FadeTransition(
                      opacity: opacityAnimation,
                      child: Container(
                        color:
                            Colors.black.withOpacity(_BACKGROUND_OPACITY_LEVEL),
                      ),
                    );
                  },
                ),
              ),

              AnimatedBuilder(
                animation: animationController,
                builder: (_, __) => SlideTransition(
                  position: topDownTransition,
                  child: buildTopBarWidget(size),
                ),
              ),
              AnimatedBuilder(
                  animation: animationController,
                  builder: (_, __) => FadeTransition(
                        opacity: opacityAnimation,
                        child: buildCenterControllersWidget(
                            size, animationController.isCompleted),
                      )),
              AnimatedBuilder(
                animation: animationController,
                builder: (_, __) => SlideTransition(
                  position: downTopTransition,
                  child: buildBottomBarWidget(size),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildLoaderWidget() => Center(
        child: LoadingVideoWidget(
          onCancel: () async {
            await _prepareToLeave();
            Navigator.pop(context);
          },
        ),
      );

  Widget buildTopBarWidget(final Size size) => Align(
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
              PopupMenuButton<_MenuOption>(
                itemBuilder: (context) => popupMenuItems(S.of(context)),
                color: Colors.transparent,
                elevation: .0,
                offset: Offset(100, 40),
                onSelected: (option) async {
                  switch (option) {
                    case _MenuOption.NEXT:
                      videoPlayerStore.nextEpisode();
                      break;

                    case _MenuOption.PREVIOUS:
                      videoPlayerStore.previousEpisode();
                      break;

                    case _MenuOption.EXIT:
                      await _prepareToLeave();
                      Navigator.pop(context);
                      break;
                  }
                },
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

  Widget buildBottomBarWidget(final Size size) => Align(
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

  List<PopupMenuItem<_MenuOption>> popupMenuItems(S locale) {
    var widgetList = <PopupMenuItem<_MenuOption>>[];

    if (videoPlayerStore.currentEpisode.previousEpisodeId.isNotEmpty)
      widgetList.add(UiUtils.createMenuItem<_MenuOption>(
        icon: Icon(
          Icons.skip_previous,
          color: Colors.white,
        ),
        value: _MenuOption.PREVIOUS,
        title: locale.previous,
      ));

    if (videoPlayerStore.currentEpisode.nextEpisodeId.isNotEmpty)
      widgetList.add(UiUtils.createMenuItem<_MenuOption>(
        icon: Icon(
          Icons.skip_next,
          color: Colors.white,
        ),
        value: _MenuOption.NEXT,
        title: locale.next,
      ));

    widgetList.add(UiUtils.createMenuItem(
      icon: Icon(
        Icons.exit_to_app,
        color: Colors.white,
      ),
      value: _MenuOption.EXIT,
      title: locale.quit,
    ));
    return widgetList;
  }
}
