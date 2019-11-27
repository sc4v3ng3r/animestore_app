import 'package:anime_app/logic/stores/StoreUtils.dart';
import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/logic/stores/search_store/SearchStore.dart';
import 'package:anime_app/ui/pages/MainScreen.dart';
import 'package:anime_app/ui/pages/RetryPage.dart';
import 'package:anime_app/ui/pages/SplashScreen.dart';
import 'package:anime_app/ui/theme/ColorValues.dart';
import 'package:bot_toast/bot_toast.dart';
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

      child: BotToastInit(
        child: MaterialApp(
          title: 'AnimeApp',
          navigatorObservers: [BotToastNavigatorObserver()],
          debugShowCheckedModeBanner: false,
          theme: ThemeData().copyWith(
            brightness: Brightness.light,

            scaffoldBackgroundColor: primaryColor,
            accentColor: accentColor,

            // text theme
            textTheme: TextTheme().copyWith(
              body1: TextStyle(
                color: textPrimaryColor
              )
            ),
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
                  case AppInitStatus.INIT_ERROR:
                    widget = RetryPage();
                    break;
                }
                return widget;
              }
          )
        ),
      ),
    );
}