import 'package:anime_app/logic/stores/StoreUtils.dart';
import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/logic/stores/genre_anime_store/GenreAnimeStore.dart';
import 'package:anime_app/src/di/dependency_injection.dart';
import 'package:anime_app/src/features/anime_details/presenter/controller/AnimeDetailsStore.dart';
import 'package:anime_app/ui/component/ItemView.dart';
import 'package:anime_app/ui/component/SliverGridViewWidget.dart';
import 'package:anime_app/ui/pages/AnimeDetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:anime_app/ui/utils/UiUtils.dart';

class GenreAnimePage extends StatefulWidget {
  final String genreName;

  const GenreAnimePage({Key? key, required this.genreName}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GenreAnimePageState();
}

class _GenreAnimePageState extends State<GenreAnimePage> {
  final ScrollController _controller = ScrollController();
  late ApplicationStore appStore;
  late GenreAnimeStore store;

  @override
  void initState() {
    super.initState();
    appStore = Provider.of<ApplicationStore>(context, listen: false);
    store = GenreAnimeStore(appStore, widget.genreName);
    store.init();
    _controller.addListener(_listener);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_listener);
  }

  void _listener() async {
    if (_controller.position.pixels >
        (_controller.position.maxScrollExtent -
            (_controller.position.maxScrollExtent / 4)))
      return await store.loadMore();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;

    return Scaffold(
      body: CustomScrollView(
        controller: _controller,
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(),
          ),
          Observer(
            builder: (_) => (store.loadingStatus == LoadingStatus.LOADING)
                ? SliverToBoxAdapter(
                    child: Container(
                      height: size.height,
                      width: size.width,
                      child: UiUtils.centredDotLoader(),
                    ),
                  )
                : (store.loadingStatus == LoadingStatus.ERROR)
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: Text('ERROR'),
                        ),
                      )
                    : Observer(
                        builder: (_) => SliverGridItemView(
                          childAspectRatio: (itemWidth / itemHeight),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              var anime = store.animeItems[index];
                              var heroTag = '${anime.id}-$index';

                              return Tooltip(
                                message: anime.title,
                                child: ItemView(
                                  imageHeroTag: heroTag,
                                  width: itemWidth,
                                  height: itemHeight,
                                  imageUrl: anime.imageUrl,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              Provider<AnimeDetailsStore>(
                                            create: (_) => AnimeDetailsStore(
                                              appStore,
                                              anime,
                                              getIt.get(),
                                              getIt.get(),
                                            ),
                                            child: AnimeDetailsScreen(
                                              heroTag: heroTag,
                                            ),
                                          ),
                                        ));
                                  },
                                ),
                              );
                            },
                            childCount: store.animeItems.length,
                          ),
                        ),
                      ),
          ),
          Observer(
            builder: (_) => SliverToBoxAdapter(
              child: (store.isLoadingMore) ? _loadingWidget() : Container(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loadingWidget() => Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: UiUtils.centredDotLoader(),
      );
}
