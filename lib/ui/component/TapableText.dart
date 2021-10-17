import 'package:flutter/material.dart';

class TapText extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;

  final Color? defaultColor;
  final Color? onTapColor;
  final double fontSize;

  const TapText(
      {Key? key,
      required this.text,
      this.onTap,
      this.defaultColor,
      this.onTapColor,
      this.fontSize = 16.0})
      : super(key: key);

  @override
  _TapTextState createState() => _TapTextState();
}

class _TapTextState extends State<TapText> {
  late Color currentColor;

  @override
  void initState() {
    currentColor = widget.defaultColor ?? Colors.white;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: widget.onTap,
          onTapDown: (details) {
            _changeColor(widget.onTapColor);
          },
          onTapUp: (details) {
            _changeColor(widget.defaultColor);
          },
          onTapCancel: () {
            _changeColor(widget.defaultColor);
          },
          child: Text(
            widget.text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: widget.fontSize,
              color: currentColor,
            ),
          ),
        ),
        Container(
          child: Icon(
            Icons.navigate_next,
            color: currentColor,
            size: 20,
          ),
        ),
      ],
    );
  }

  void _changeColor(Color? color) {
    setState(() {
      currentColor = color ?? Colors.white;
    });
  }
}
