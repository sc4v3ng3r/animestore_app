import 'package:anime_app/logic/stores/StoreUtils.dart';
import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/logic/stores/search_store/SearchStore.dart';
import 'package:anime_app/ui/pages/MainScreen.dart';
import 'package:anime_app/ui/pages/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

void main() {

  runApp( MyApp() );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
    )
  );
}


class MyApp extends StatelessWidget {
  final ApplicationStore appStore = ApplicationStore();

  @override
  Widget build(BuildContext context) =>
    MultiProvider(
        providers: [
          Provider<ApplicationStore>.value(value: appStore),
          Provider<SearchStore>.value(value: SearchStore(appStore)),
        ],

      child: MaterialApp(
        title: 'AnimeApp',
        debugShowCheckedModeBanner: false,
//        theme: ThemeData().copyWith(
//          primaryColor: primaryColor,
//          primaryColorDark: primaryColor,
//          primaryColorLight: primaryLight,
//          backgroundColor: Colors.white,
//          scaffoldBackgroundColor: primaryColor,
//        ),

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
