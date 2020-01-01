import 'package:anime_app/i18n/AnimeStoreLocalization.dart';
import 'package:anime_app/ui/pages/about_pages/AboutAppPage.dart';
import 'package:anime_app/ui/pages/about_pages/OpenSourceLibraryPage.dart';
import 'package:anime_app/ui/theme/ColorValues.dart';
import 'package:anime_app/ui/utils/UiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutListWidget extends StatelessWidget {
  final double iconSize = 32.0;

  @override
  Widget build(BuildContext context) {

    final locale = AnimeStoreLocalization.of(context);
    final defaultTrailing = Icon(
      Icons.navigate_next,
      color: Colors.white,
      );

    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          _buildItem(
            onTap: () => Navigator.push(context, 
                CupertinoPageRoute(
                  builder: (_) => AboutAppPage(),
                )
              ),
            title: locale.animeStore,
            subtitle: locale.appInfoSubtitle,
            icon: UiUtils.getAppIcon(size: iconSize),
            trailing: defaultTrailing,
          ),

          _buildItem(
            title: locale.animeStoreLicenseTitle,
            subtitle: locale.animeStoreLicensesubtitle,
            icon: _buildDefaultIcon(Icons.assignment),
            trailing: defaultTrailing,
            onTap: (){}
          ),

          _buildItem(
            icon: _buildDefaultIcon(Icons.info),
            title: locale.openSourceLibraryTitle,
            subtitle: locale.openSourceLibrarysubtitle,
            trailing: defaultTrailing,
            onTap: (){
              Navigator.push(context, 
                CupertinoPageRoute(
                  builder: (_) => OpenSourceLibraryPage(),
                )
              );
            }
          ),
          
        ],
      ),
    );
  }


  Widget _buildDefaultIcon(IconData iconData) => 
      Icon(iconData,
        size: iconSize,
        color: Colors.white,
  );
  Widget _buildItem(
          {@required VoidCallback onTap, @required String title, 
           String subtitle, @required Widget icon, Widget trailing}) =>
      Container(
        child: ListTile(
          onTap: onTap,
          leading: icon,
          title: Text(title, style: TextStyle(
            fontWeight: FontWeight.w600
          ),),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(subtitle ?? ''),

              Container(
                margin: EdgeInsets.only(top: 8.0),
                height: .5,
                color: accentColor.withOpacity(.7),
              ),
            ],
          ),

          trailing: trailing,
        ),
      );
}
