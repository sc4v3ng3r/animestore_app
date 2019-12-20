import 'package:anime_app/ui/pages/about_pages/OpenSourceLibraryPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingListWidget extends StatelessWidget {
  final iconSize = 32.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          
          _buildItem(
            onTap: (){},
            title: 'About Anime Store',
            subtitle: 'What is anime store',
            icon: SvgPicture.asset(
              'assets/icons/anistore.svg',
              color: Colors.white,
              width: iconSize,
              height: iconSize,
            ),
          ),

          _buildItem(
            title: 'Anime Store License',
            subtitle: 'License terms of Anime Store',
            icon: _buildDefaultIcon(Icons.assignment),
            onTap: (){}
          ),

          _buildItem(
            icon: _buildDefaultIcon(Icons.info_outline),
            title: 'Open Source Libraries',
            subtitle: 'Open source libraries used by Anime Store',
            onTap: (){
              print('push page');
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
          @required String subtitle, @required Widget icon}) =>
      Container(
        child: ListTile(
          onTap: onTap,
          leading: icon,
          title: Text(title),
          subtitle: Text(subtitle),
        ),
      );
}
