import 'package:anime_app/generated/l10n.dart';
import 'package:anime_app/ui/theme/ColorValues.dart';
import 'package:flutter/material.dart';

class AnimeStoreAcceptDialog extends StatelessWidget {
  final String title;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final String bodyMessage;

  const AnimeStoreAcceptDialog({
    Key? key,
    required this.title,
    required this.bodyMessage,
    this.onConfirm,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24.0),
    );

    final locale = S.of(context);

    return AlertDialog(
      backgroundColor: primaryColor,
      shape: defaultShape,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            bodyMessage,
            style: TextStyle(color: Colors.white),
          ),
          Container(
            margin: EdgeInsets.only(top: 24.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  shape: defaultShape,
                  onPressed: onCancel,
                  textColor: Colors.white,
                  child: Text(locale.cancel),
                  color: accentColor,
                ),
                FlatButton(
                  onPressed: onConfirm,
                  shape: defaultShape,
                  textColor: Colors.white,
                  child: Text(locale.confirm),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
