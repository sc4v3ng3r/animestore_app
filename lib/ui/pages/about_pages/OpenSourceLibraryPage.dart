import 'package:anime_app/ui/component/app_bar/AnimeStoreIconAppBar.dart';
import 'package:anime_app/ui/utils/Constants.dart';
import 'package:flutter/material.dart';

class OpenSourceLibraryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final libraries = librariesMap.keys.toList();

    return Scaffold(
      appBar: AnimeStoreIconAppBar(),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          var title = libraries[index];
          var subtitle = librariesMap[title];
          return libraryItem(title, subtitle);
        },
        itemCount: libraries.length,
      ),
    );
  }

  Widget libraryItem(String title, String? subtitle) => ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          subtitle ?? "",
          textAlign: TextAlign.justify,
        ),
      );
}
