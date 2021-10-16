import 'package:anime_app/generated/l10n.dart';
import 'package:anime_app/ui/component/button/RoundedRaisedButton.dart';
import 'package:flutter/material.dart';

class LoadingVideoWidget extends StatelessWidget {
  final VoidCallback? onCancel;

  const LoadingVideoWidget({Key? key, this.onCancel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locale = S.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Center(
          child: CircularProgressIndicator(),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 16.0),
            child: RoundedRaisedButton(
              locale.cancel,
              onPressed: onCancel,
            ),
          ),
        ),
      ],
    );
  }
}
