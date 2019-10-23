import 'package:anime_app/logic/ApplicationBloc.dart';
import 'package:anime_app/ui/component/AnimeGridWidget.dart';
import 'package:anime_app/ui/component/SearchWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum MainScreenNavigation { HOME, SEARCH }

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  MainScreenNavigation currentNav = MainScreenNavigation.HOME;
  ApplicationBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = Provider.of<ApplicationBloc>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:  WillPopScope(
          child: (currentNav == MainScreenNavigation.HOME)
        ? AnimeGridWidget()
        : SearchWidget(),
          onWillPop: () async {
            var flag = true;
            if (currentNav != MainScreenNavigation.HOME){
              setState(() {
                currentNav = MainScreenNavigation.HOME;
                flag = false;
              });
            }
            return flag;
          }
      ),

      bottomNavigationBar: _createBottomBar(),
    );
  }


  void _changePageBody(int index){

    setState(() {
      currentNav = MainScreenNavigation.values[index];
    });
  }

  Widget _createBottomBar () => BottomNavigationBar(
    selectedItemColor: Theme.of(context).accentColor,
    //unselectedItemColor: Theme.of(context).,
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(

        title: Text('Animes'),
        icon: Icon(
          Icons.live_tv,
        ),
      ),

      BottomNavigationBarItem(
        title: Text('Buscar'),
        icon: Icon(
          Icons.search,
        ),
      ),
    ],

    onTap: _changePageBody,
    currentIndex: currentNav.index,
  );
}
