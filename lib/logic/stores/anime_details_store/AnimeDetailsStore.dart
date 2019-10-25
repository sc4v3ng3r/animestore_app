import 'package:anime_app/logic/Constants.dart';
import 'package:anime_app/logic/stores/StoreUtils.dart';
import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:mobx/mobx.dart';
import 'package:palette_generator/palette_generator.dart';
import 'dart:ui' as ui;
part 'AnimeDetailsStore.g.dart';

class AnimeDetailsStore = _AnimeDetailsStore with _$AnimeDetailsStore;

abstract class _AnimeDetailsStore with Store {

  final ApplicationStore applicationStore;

  @observable
  Color backgroundColor = IMAGE_BACKGROUND_COLOR;

  @observable
  LoadingStatus loadingStatus;

  @observable
  ObservableList<String> visualizedEps = ObservableList();

  AnimeDetails animeDetails;

  _AnimeDetailsStore(this.applicationStore);

  @action setLoadingStatus(LoadingStatus data) => loadingStatus = data;

  @action addVisualizedEp(String episodeId) => visualizedEps.add(episodeId);


  @action setBackgroundColor(Color color) => backgroundColor = color;

  void loadAnimeDetails(String id) async {
    if (loadingStatus == LoadingStatus.LOADING)
      return;

    try{
      setLoadingStatus(LoadingStatus.LOADING);
      animeDetails = await applicationStore.getAnimeDetails(id);
      //extractColorFromImage();
      setLoadingStatus(LoadingStatus.DONE);

    }
    on CrawlerApiException catch(ex){
      print(ex);
      setLoadingStatus(LoadingStatus.ERROR);
    }

  }

  void extractColorFromImage() async {
    var url = animeDetails.imageUrl;
    ImageStreamListener listener = ImageStreamListener(
            (info, flag){
              print(info);
              Size size = Size(info.image.width.toDouble(),info.image.height.toDouble() );

              Rect region = Offset.zero & size;
              _updatePaletteGenerator(region, info.image, size);
            });
    AdvancedNetworkImage(url, useDiskCache: true,scale: .5)..resolve(
      ImageConfiguration.empty,
    ).addListener(listener);


  }

  Future<void> _updatePaletteGenerator(Rect newRegion, ui.Image image, Size size) async {

    var paletteGenerator = await PaletteGenerator.fromImage(
      image,
      region: newRegion,
      maximumColorCount: 5,
    );

    if (paletteGenerator.dominantColor != null){
      print('Generated colors: ${paletteGenerator.colors}');
      print('Dominant: ${paletteGenerator.dominantColor?.color}');
      setBackgroundColor(paletteGenerator.dominantColor.color);
    }

  }
}


