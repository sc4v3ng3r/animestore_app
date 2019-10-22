import 'package:anime_app/logic/ApplicationBloc.dart';
import 'package:anime_app/ui/pages/AnimeDetailsScreen.dart';
import 'package:anime_app/ui/component/ItemView.dart';
import 'package:anitube_crawler_api/anitube_crawler_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimeGridWidget extends StatefulWidget {
  @override
  _AnimeGridWidgetState createState() => _AnimeGridWidgetState();
}

class _AnimeGridWidgetState extends State<AnimeGridWidget> {
  ApplicationBloc bloc;

  final ScrollController _controller = ScrollController(
      initialScrollOffset: 0,
  );

  @override
  void initState() {
    super.initState();
    bloc = Provider.of<ApplicationBloc>(context, listen: false);
    _controller.addListener(_listener);
  }

  void _listener() async {
    if (_controller.position.pixels > (_controller.position.maxScrollExtent
        - (_controller.position.maxScrollExtent/4)) )
     await bloc.loadData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;

    final appBar = SliverAppBar(
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.video_library,),
          Container(width: 4.0,),
          Text('AnimeApp'),
        ],
      ),
      snap: false,
      floating: true,
      pinned: false,
    );

    return CustomScrollView(
      controller: _controller,

      physics: BouncingScrollPhysics(),
      slivers: <Widget>[

        appBar,

        StreamBuilder<List<AnimeItem>>(
          stream: bloc.animesObservable,
            initialData: bloc.animeDataList,
            builder: (context, snapshot){
            print('Size: ${_controller.position.maxScrollExtent}  Current: ${_controller.position.pixels}');

            return SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 6.0,
                    childAspectRatio: ( itemWidth / itemHeight)
                  ),

                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          print('Creating $index');
                          return Tooltip(
                            message: snapshot.data[index].title,

                            child: ItemView(
                              width: itemWidth,
                              height: itemHeight,
                              imageUrl: snapshot.data[index].imageUrl,
                              heroTag: snapshot.data[index].id,
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) =>
                                        AnimeDetailsScreen(
                                          title: snapshot.data[index].title,
                                          imageUrl: snapshot.data[index].imageUrl,
                                          heroTag: snapshot.data[index].id,
                                        )
                                    )
                                );
                              },
                            ),
                          );
                        },
                    childCount: snapshot.data.length,
                  ),

                ),
            );
            }
        ),

        SliverToBoxAdapter(
          child: StreamBuilder<bool>(
            stream: bloc.isLoading,
            initialData: false,
            builder: (context, snapshot) =>
              (snapshot.data) ? Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator()
                  ),
                ],
              ) : Container()
          ),
        ),
      ],
    );
  }


  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }
}
