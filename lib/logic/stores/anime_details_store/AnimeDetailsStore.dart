import 'dart:async';
import 'dart:typed_data';

import 'package:anime_app/logic/Constants.dart';
import 'package:anime_app/logic/stores/StoreUtils.dart';
import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:palette_generator/palette_generator.dart';

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

    try {
      setLoadingStatus(LoadingStatus.LOADING);
      animeDetails = await applicationStore.getAnimeDetails(id);
      setLoadingStatus(LoadingStatus.DONE);
    }
    on CrawlerApiException catch (ex) {
      print(ex);
      setLoadingStatus(LoadingStatus.ERROR);
    }
  }

  Future<Uint8List> extractDominantColor(Uint8List imgData) async {
    final double size = 180;
    var img = Image.memory(imgData, width: size, height: size, );
    final imgSize = Size(size, size);
    PaletteGenerator.fromImageProvider(
      img.image,
      size: imgSize,
      region: Offset.zero & imgSize,
      maximumColorCount: 4,
    ).then( (generator){
      if (generator.dominantColor!= null){
        print('We got dominant color!');
        setBackgroundColor(generator.dominantColor.color);
      }
    } );

    return imgData;

  }

}
