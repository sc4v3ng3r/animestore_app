

import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {

  final IconData icon;
  final Color iconColor;
  final Color textColor;
  final String text;
  final double size;

  const InfoWidget({Key key,
    this.icon = Icons.clear,
    this.text = '',
    this.textColor = Colors.grey,
    this.iconColor =  Colors.grey,
    @required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: size / 2,
            color: iconColor,
          ),

          Text(text,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 32,
              color: textColor,
            ),
          )
        ],
      ),
    );
  }
}
