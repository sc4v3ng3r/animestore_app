import 'package:anime_app/ui/theme/ColorValues.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomListNotification extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final bool flag;
  const CustomListNotification(
      {Key? key,
      required this.imagePath,
      required this.flag,
      required this.title,
      this.subtitle = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: primaryColor.withOpacity(.6),
      child: ListTile(
          leading: Container(
            child: Image(
              image: CachedNetworkImageProvider(imagePath),
              //image: AdvancedNetworkImage(imagePath, useDiskCache: true,),
              fit: BoxFit.fill,
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  offset: Offset.zero, // (2.0, 2.0),
                  blurRadius: 5.0,
                ),
              ],
            ),
          ),
          title: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(subtitle),
          trailing: flag
              ? Icon(
                  Icons.done,
                  color: Colors.greenAccent,
                )
              : Icon(
                  Icons.clear,
                  color: Colors.red,
                )),
    );
  }
}
