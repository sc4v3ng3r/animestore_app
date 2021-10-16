import 'package:anime_app/generated/l10n.dart';
import 'package:anime_app/ui/component/button/RoundedRaisedButton.dart';
import 'package:flutter/material.dart';

class UnavailableVideoWidget extends StatelessWidget {
  final VoidCallback? retryCallback, onBackCallback;

  const UnavailableVideoWidget({
    Key? key,
    this.onBackCallback,
    this.retryCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locale = S.of(context);

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Icon(
            Icons.error,
            color: Colors.red,
            size: 82,
          )),
          Container(
            height: 10,
          ),
          Text(
            locale.videoUnavailable,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
                color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RoundedRaisedButton(
                  locale.back,
                  onPressed: onBackCallback,
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                Container(width: 16.0),
                RoundedRaisedButton(
                  locale.tryAgain,
                  onPressed: retryCallback,
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
