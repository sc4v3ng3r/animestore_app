import 'package:anime_app/ui/theme/ColorValues.dart';
import 'package:flutter/material.dart';

class RoundedRaisedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color backgroundColor;
  final double radius;
  final Icon icon;

  const RoundedRaisedButton(this.label,
      {Key key, this.onPressed, this.backgroundColor, this.radius, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      onPressed: onPressed,
      icon: icon ?? Container(),
      label: Text(
        label,
        style: TextStyle(color: textPrimaryColor),
      ),
      color: backgroundColor ?? accentColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 25)),
    );
  }
}
