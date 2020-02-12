import 'package:anime_app/ui/theme/ColorValues.dart';
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
                
                _createButton(
                  label: locale.back,
                  icon: Icon( Icons.arrow_back,
                    color: Colors.white,
                  ),
                  callback: onBackCallback,
                ),
                
                Container( width: 16.0 ),
                
                _createButton(
                  callback: retryCallback,
                  icon: Icon(Icons.refresh,
                    color: Colors.white,
                  ),
                  label: locale.tryAgain,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createButton({VoidCallback callback, Icon icon,
    String label, Color backgroundColor }) => RaisedButton.icon(
                  onPressed: callback,
                  icon: icon,
                  label: Text(label,
                    style: TextStyle(color: textPrimaryColor),
                  ),
                  color: backgroundColor ?? accentColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                );
}
