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
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'generated/l10n.dart';

void main() {
  runApp(new MyApp());

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  final ApplicationStore appStore = ApplicationStore();

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<ApplicationStore>.value(value: appStore),
          Provider<SearchStore>.value(value: SearchStore(appStore)),
        ],
        child: MaterialApp(
            title: 'AniStore',
            builder: BotToastInit(),
            navigatorObservers: [BotToastNavigatorObserver()],
            debugShowCheckedModeBanner: false,
            theme: ThemeData().copyWith(
              brightness: Brightness.dark,

              scaffoldBackgroundColor: primaryColor,
              accentColor: accentColor,

              // text theme
              textTheme: TextTheme()
                  .copyWith(bodyText2: TextStyle(color: textPrimaryColor)),
            ),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            home: Observer(builder: (context) {
              var widget;
              switch (appStore.appInitStatus) {
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
            })),
      );
}
