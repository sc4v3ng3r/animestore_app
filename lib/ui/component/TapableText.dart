import 'package:flutter/material.dart';

class TapText extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  final Color defaultColor;
  final Color onTapColor;
  final double fontSize;

  const TapText({Key key, this.text, this.onTap,
    this.defaultColor, this.onTapColor,
    this.fontSize}) : super(key: key);

  @override
  _TapTextState createState() => _TapTextState();
}

class _TapTextState extends State<TapText> {
  Color currentColor;

  @override
  void initState() {
    currentColor = widget.defaultColor ?? Colors.white;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (details) { _changeColor(widget.onTapColor);},
      onTapUp: (details){ _changeColor(widget.defaultColor); },
      onTapCancel: () { _changeColor(widget.defaultColor);},
      child: Text(widget.text ?? '',
        style: TextStyle(
          fontSize: widget.fontSize ?? 16,
          color: currentColor,
        ),
      ),
    );
  }

  void _changeColor(Color color) {
    setState(() {
      currentColor = color ?? Colors.white;
    });
  }
}
