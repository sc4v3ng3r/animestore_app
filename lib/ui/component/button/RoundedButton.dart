import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final double? size;
  final VoidCallback? onTap;
  final String title;
  const RoundedButton({Key? key, required this.title, this.onTap, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultSize = 50.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      verticalDirection: VerticalDirection.down,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: ClipOval(
            child: Stack(
              children: <Widget>[
                Container(
                  width: size ?? defaultSize,
                  height: size ?? defaultSize,
                  color: Colors.white.withOpacity(.3),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    elevation: .0,
                    child: InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.add,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.only(top: 8.0),
            width: defaultSize + 20,
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
