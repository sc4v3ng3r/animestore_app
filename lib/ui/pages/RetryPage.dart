import 'package:anime_app/i18n/AnimeStoreLocalization.dart';
import 'package:anime_app/logic/stores/application/ApplicationStore.dart';
import 'package:anime_app/ui/theme/ColorValues.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RetryPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var appStore = Provider.of<ApplicationStore>(context);
    var size = MediaQuery.of(context).size;
    final defaultMargin = 10.0;
    final locale = AnimeStoreLocalization.of(context);

    return Container(
      width: size.width,
      height: size.height,
      child: Material(
          color: primaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24,),
            child: Column(
              mainAxisSize: MainAxisSize.max,

              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[

                Icon(Icons.error, size: size.height * .2,
                  color: Colors.red,
                ),

                Container(
                  margin: EdgeInsets.only(top: defaultMargin),
                  child: Text(locale.problemsWithTheServer,
                    maxLines: 4,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: defaultMargin),
                  child: RaisedButton.icon(
                      onPressed: () => appStore.appRetry(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      color: Colors.white,
                      icon: Icon(Icons.refresh, color: Colors.green,),
                      label: Text(locale.tryAgain),
                  ),
                )
              ],

            ),
          ),
        ),
    );
  }
}
