import 'package:anime_app/ui/theme/ColorValues.dart';
import 'package:anime_app/ui/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OpenSourceLibraryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final libraries = librariesMap.keys.toList();

    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SvgPicture.asset(
                'assets/icons/anistore.svg',
                  color: Colors.white,
                  width: 32,
                  height: 32,
              ),
              Container(
                margin: EdgeInsets.only(left: 12.0),
                child: Text('Anime Store')
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index){
          var title = libraries[index];
          var subtitle = librariesMap[title];
          return libraryItem(title, subtitle);
        },

        itemCount: libraries.length,
      ),
    );
  }

  Widget libraryItem(String title, String subtitle) =>
    ListTile(
      title: Text(title, style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500
      ),),
      subtitle: Text(subtitle, textAlign: TextAlign.justify,),
    );
}
