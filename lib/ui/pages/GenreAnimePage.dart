import 'package:anime_app/logic/stores/StoreUtils.dart';
import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/logic/stores/genre_anime_store/GenreAnimeStore.dart';
import 'package:anime_app/ui/component/ItemView.dart';
import 'package:anime_app/ui/component/SliverGridViewWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class GenreAnimePage extends StatefulWidget {
  final String genreName;

  const GenreAnimePage({Key key, @required this.genreName}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GenreAnimePageState();

}

class _GenreAnimePageState extends State<GenreAnimePage> {

  final ScrollController _controller = ScrollController();
  ApplicationStore appStore;
  GenreAnimeStore store;

  @override
  void initState() {
    super.initState();
    appStore = Provider.of<ApplicationStore>(context, listen: false);
    store = GenreAnimeStore(appStore,widget.genreName );
    store.init();
    _controller.addListener( _listener );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener( _listener );
    store = null;
  }

  void _listener() async {
    if (_controller.position.pixels > (_controller.position.maxScrollExtent -
        (_controller.position.maxScrollExtent / 4)) )
      return await store.loadMore();

  }
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;
//
//    final appBar = SliverAppBar(
//      centerTitle: true,
//      title: Row(
//          mainAxisSize: MainAxisSize.min,
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Icon(
//              Icons.ondemand_video,
//            ),
//            Container(
//              width: 4.0,
//            ),
//            Text('${widget.genreName}'),
//          ],
//        ),
//
//      snap: false,
//      floating: true,
//      pinned: false,
//    );

    return Scaffold(
      body: CustomScrollView(
        controller: _controller,
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(child: Container(),),

          Observer(
            builder: (_) =>
            (store.loadingStatus == LoadingStatus.LOADING) ?
                SliverToBoxAdapter(
                  child: Container(
                    height: size.height,
                    width: size.width,
                    child: Center(
                      child: _loadingWidget(),
                    ),
                  ),
                )
                : (store.loadingStatus == LoadingStatus.ERROR) ?
                  SliverToBoxAdapter(
                    child: Center(child: Text('ERROR'),),
                  ) :

                Observer(
                  builder: (_) =>
                      SliverGridItemView(
                        childAspectRatio: (itemWidth / itemHeight),
                        delegate: SliverChildBuilderDelegate(
                            (context, index){
                              var anime = store.animeItems[index];

                          return Tooltip(
                            message: anime.title ,
                            child: ItemView(
                              width: itemWidth,
                              height: itemHeight,
                              imageUrl: anime.imageUrl,
                              onTap: (){},
                            ),
                          );
                        },
                        childCount: store.animeItems.length,
                      ),),
                ),


          ),

          Observer(
            builder: (_) =>
                SliverToBoxAdapter(
                  child: (store.isLoadingMore) ?
                  _loadingWidget()
                      : Container(),
                ),
          ),
        ],
      ),
    );
  }

  Widget _loadingWidget() =>
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(8.0),
              child: CircularProgressIndicator()),
        ],
      );
}
