import 'package:anime_app/i18n/AnimeStoreLocalization.dart';
import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/ui/component/app_bar/AnimeStoreIconAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var info = Provider.of<ApplicationStore>(context).appInfo;
    final locale = AnimeStoreLocalization.of(context);

    return Scaffold(
      appBar: AnimeStoreIconAppBar(),
      body: ListView(
        shrinkWrap: true,
        
        children: <Widget>[

          ListTile(
            title: Text(locale.appNameTitle),
            subtitle: Text(locale.animeStore),
          ),

          ListTile(
            title: Text(locale.versionTitle),
            subtitle: Text(info.version ?? ''),
          ),

          ListTile(
            title: Text(locale.buildNumberTitle),
            subtitle: Text(info.buildNumber ?? ''),
          ),
        ],
      ),
    );
  }
}