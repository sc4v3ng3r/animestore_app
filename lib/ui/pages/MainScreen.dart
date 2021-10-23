import 'package:anime_app/generated/l10n.dart';
import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/ui/component/AnimeGridWidget.dart';
import 'package:anime_app/src/features/search/presenter/widget/search_widget.dart';
import 'package:anime_app/ui/component/AboutListWidget.dart';
import 'package:anime_app/ui/pages/HomePage.dart';
import 'package:anime_app/ui/theme/ColorValues.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum MainScreenNavigation { HOME, ANIME_LIST, SEARCH, SETTINGS }

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  MainScreenNavigation currentNav = MainScreenNavigation.HOME;
  late ApplicationStore appStore;
  late S locale;

  @override
  void initState() {
    super.initState();
    appStore = Provider.of<ApplicationStore>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    locale = S.current;

    return Scaffold(
      body: WillPopScope(
          child: _getCurrentPage(),
          onWillPop: () async {
            var flag = true;
            if (currentNav != MainScreenNavigation.HOME) {
              setState(() {
                currentNav = MainScreenNavigation.HOME;
                flag = false;
              });
            }
            return flag;
          }),
      bottomNavigationBar: _createBottomBar(),
    );
  }

  Widget _getCurrentPage() {
    var widget;
    switch (currentNav) {
      case MainScreenNavigation.HOME:
        widget = HomePage();
        break;
      case MainScreenNavigation.ANIME_LIST:
        widget = AnimeGridWidget();
        break;
      case MainScreenNavigation.SEARCH:
        widget = SearchWidget();
        break;

      case MainScreenNavigation.SETTINGS:
        widget = AboutListWidget();
        break;
    }
    return widget;
  }

  void _changePageBody(int index) {
    setState(() {
      currentNav = MainScreenNavigation.values[index];
    });
  }

  Widget _createBottomBar() => Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: accentColor,
            offset: Offset(.0, 5.0),
            blurRadius: 12.0,
          )
        ]),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: accentColor,
          backgroundColor: primaryColor,
          unselectedItemColor: secondaryColor,
          //fixedColor: primaryColor,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: locale.home,
              icon: Icon(
                Icons.home,
              ),
            ),
            BottomNavigationBarItem(
              label: locale.animes,
              icon: Icon(
                Icons.live_tv,
              ),
            ),
            BottomNavigationBarItem(
              label: locale.search,
              icon: Icon(
                Icons.search,
              ),
            ),
            BottomNavigationBarItem(
                label: locale.info, icon: Icon(Icons.info_outline))
          ],

          onTap: _changePageBody,
          currentIndex: currentNav.index,
        ),
      );
}
