import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/ui/component/app_bar/AnimeStoreIconAppBar.dart';
import 'package:anime_app/ui/utils/UiUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var info = Provider.of<ApplicationStore>(context).appInfo;
    
    return Scaffold(
      appBar: AnimeStoreIconAppBar(),
      body: ListView(
        shrinkWrap: true,
        
        children: <Widget>[

          ListTile(
            title: Text('Application Name'),
            subtitle: Text('Anime Store'),
          ),

          ListTile(
            title: Text('Version'),
            subtitle: Text(info.version ?? ''),
          ),

          ListTile(
            title: Text('Build Number'),
            subtitle: Text(info.buildNumber ?? ''),
          ),
        ],
      ),
    );
  }
}