import 'package:anime_app/ui/theme/ColorValues.dart';
import 'package:flutter/material.dart';

class AnimeStoreAcceptDialog extends StatelessWidget {
  
  final String title;
  final VoidCallback onAccept;
  final VoidCallback onDenied;
  final String bodyMessage;

  const AnimeStoreAcceptDialog({Key key, 
    this.title, 
    this.bodyMessage,
    this.onAccept, 
    this.onDenied,
    }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      title: Text(title, style: TextStyle(
        color: Colors.white,
      ),),
      content: Text(bodyMessage, style: TextStyle(
        color: Colors.white
      ),),
      actions: <Widget>[

        FlatButton(
          child: Text('Deny'),
        ),
        FlatButton(
          child: Text('Confirm'),
        ),
      ],
    );
  }
}