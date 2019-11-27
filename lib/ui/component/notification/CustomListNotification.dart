import 'package:anime_app/ui/theme/ColorValues.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

class CustomListNotification extends StatelessWidget {

  final String imagePath;
  final String title;
  final String subtitle;
  final bool flag;
  const CustomListNotification({Key key, this.imagePath,
    this.flag, this.title, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: primaryColor.withOpacity(.6),
      child: ListTile(

        leading: Image(
          image: AdvancedNetworkImage(imagePath, useDiskCache: true,),
          fit: BoxFit.fill,
        ),

        title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis,),
        subtitle: Text(subtitle),
        trailing: (flag == null || flag) ? Icon(Icons.done, color: Colors.greenAccent,)
            :  Icon(Icons.clear, color: Colors.red,)

      ),
    );
  }
}
