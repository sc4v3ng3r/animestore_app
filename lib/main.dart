import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/logic/stores/StoreUtils.dart';
import 'package:anime_app/logic/stores/search_store/SearchStore.dart';
import 'package:anime_app/ui/pages/MainScreen.dart';
import 'package:anime_app/ui/pages/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

void main() => runApp( MyApp() );

class MyApp extends StatelessWidget {
  static final ApplicationStore appStore = ApplicationStore()..initApp();
  final SearchStore searchStore = SearchStore(appStore);

  @override
  Widget build(BuildContext context) =>
    MultiProvider(
        providers: [
          Provider<ApplicationStore>.value(value: appStore),
          Provider<SearchStore>.value(value: searchStore),
        ],

      child: MaterialApp(
        title: 'AnimeApp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        home: Observer(
            builder: (context){
              var widget;
              switch(appStore.appInitStatus){
                case AppInitStatus.INITIALIZING:
                  widget = SplashScreen();
                  break;
                case AppInitStatus.INITIALIZED:
                  widget = MainScreen();
                  break;
                case AppInitStatus.ERROR:
                  widget = Container(color: Colors.red,);
                  break;
              }
              return widget;
            }
        )
      ),
    );
}
