import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/ui/component/AnimeGridWidget.dart';
import 'package:anime_app/ui/component/SearchWidget.dart';
import 'package:anime_app/ui/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum MainScreenNavigation { HOME, ANIME_LIST, SEARCH}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  MainScreenNavigation currentNav = MainScreenNavigation.HOME;
  ApplicationStore appStore;
  @override
  void initState() {
    super.initState();
    appStore = Provider.of<ApplicationStore>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: WillPopScope(

          child: _getCurrentPage(),

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

  Widget _getCurrentPage() {
    var widget;
    switch(currentNav){
      case MainScreenNavigation.HOME:
       widget = HomePage();
        break;
      case MainScreenNavigation.ANIME_LIST:
        widget = AnimeGridWidget();
        break;
      case MainScreenNavigation.SEARCH:
        widget = SearchWidget();
        break;
    }
    return widget;
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

        title: Text('Home'),
        icon: Icon(
          Icons.home,
        ),
      ),

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
