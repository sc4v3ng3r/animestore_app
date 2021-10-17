import 'package:flutter/material.dart';

class TitleHeaderWidget extends StatelessWidget {
  final String? title;
  final TextStyle? style;
  final Color? iconColor;
  final IconData? iconData;
  final String? heroTag;
  final VoidCallback? onTap;

  const TitleHeaderWidget(
      {Key? key,
      this.title,
      this.style,
      this.iconData,
      this.onTap,
      this.iconColor,
      this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            iconData,
            color: iconColor,
            size: 28,
          ),
          Container(
            width: 8.0,
          ),
          Flexible(
            child: Hero(
              tag: heroTag ?? UniqueKey().toString(),
              child: Container(
                child: Material(
                  color: Colors.transparent,
                  elevation: .0,
                  child: Text(
                    '$title',
                    style: style,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
