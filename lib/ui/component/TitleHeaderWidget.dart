import 'package:flutter/material.dart';

class TitleHeaderWidget extends StatelessWidget {
  final String title;
  final TextStyle style;
  final Color iconColor;
  final IconData iconData;
  final String heroTag;
  final VoidCallback onTap;

  const TitleHeaderWidget({Key key,
    this.title,
    this.style,
    this.iconData,
    this.onTap,
    this.iconColor, this.heroTag}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: heroTag ?? UniqueKey().toString(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(iconData, color: iconColor, size: 28,),
            Container(width: 4.0,),
            Text('$title', style: style,),
            (onTap != null) ?
                Icon(Icons.navigate_next, color: iconColor, size: 28,)
                : Container(),
          ],
        ),
      ),
    );
  }
}
