import 'package:anime_app/ui/theme/ColorValues.dart';
import 'package:flutter/material.dart';

class RoundedRaisedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color? backgroundColor;
  final double radius;
  final Icon? icon;

  const RoundedRaisedButton(this.label,
      {Key? key,
      this.onPressed,
      this.backgroundColor,
      this.radius = 25,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon ?? Container(),
        label: Text(label, style: TextStyle(color: textPrimaryColor)),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
        ));
  }
}
