import 'package:anime_app/ui/component/button/RoundedRaisedButton.dart';
import 'package:flutter/material.dart';
import 'package:anime_app/i18n/AnimeStoreLocalization.dart';

class UnavailableVideoWidget extends StatelessWidget {
  final double width, height;
  final VoidCallback retryCallback, onBackCallback;
  
  const UnavailableVideoWidget(
      {Key key,
      this.onBackCallback,
      this.retryCallback,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locale = AnimeStoreLocalization.of(context);

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
            )
          ),
          
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
                  icon: Icon( Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                
                Container( width: 16.0 ),
                
                RoundedRaisedButton(
                  locale.tryAgain,
                  onPressed: retryCallback,
                  icon: Icon(Icons.refresh,
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
