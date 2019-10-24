import 'package:anime_app/logic/ApplicationBloc.dart';
import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/logic/stores/StoreUtils.dart';
import 'package:anime_app/ui/pages/MainScreen.dart';
import 'package:anime_app/ui/pages/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

void main() => runApp( MyApp() );

class MyApp extends StatelessWidget {
  final ApplicationBloc bloc = ApplicationBloc();
  final ApplicationStore appStore = ApplicationStore()..initApp();

  @override
  Widget build(BuildContext context) {

    Observer(
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
    );

    return MultiProvider(
        providers: [
          Provider<ApplicationStore>.value(value: appStore),
          Provider<ApplicationBloc>.value(value: bloc),
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

//    return Provider<ApplicationBloc>(
//      builder: (_) => bloc,
//
//      child: MaterialApp(
//        title: 'AnimeApp',
//        debugShowCheckedModeBanner: false,
//        theme: ThemeData(
//         primarySwatch: Colors.blue,
//        ),
//        home: FutureBuilder<bool>(
//          future: bloc.init(),
//          initialData: false,
//          builder: (context, snapshot){
//
//            if (!snapshot.hasData || !snapshot.data)
//              return SplashScreen();
//
//            if (snapshot.data)
//              return MainScreen();
//
//            else
//              return Container(
//                color: Colors.red,
//              );
//          }
//        ),
//      ),
//
//      dispose: (_, bloc) => bloc.dispose(),
//    );
  }
}
