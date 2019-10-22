import 'package:anime_app/logic/ApplicationBloc.dart';
import 'package:anime_app/ui/pages/MainScreen.dart';
import 'package:anime_app/ui/pages/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp( MyApp() );

class MyApp extends StatelessWidget {
  final ApplicationBloc bloc = ApplicationBloc();

  @override
  Widget build(BuildContext context) {

    return Provider<ApplicationBloc>(
      builder: (_) => bloc,

      child: MaterialApp(
        title: 'AnimeApp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder<bool>(
          future: bloc.init(),
          initialData: false,
          builder: (context, snapshot){

            if (!snapshot.hasData || !snapshot.data)
              return SplashScreen();

            if (snapshot.data)
              return MainScreen();

            else
              return Container(
                color: Colors.red,
              );
          }
        ),
      ),

      dispose: (_, bloc) => bloc.dispose(),
    );
  }
}
