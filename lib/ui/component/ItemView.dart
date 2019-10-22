import 'dart:ui';
import 'package:anime_app/logic/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

typedef OnTap = void Function();

class ItemView extends StatelessWidget {
  final String imageUrl;
  final OnTap onTap;
  final double width, height;
  final String heroTag;

  const ItemView({
    @required this.width,
    @required this.height,
    Key key,
    this.imageUrl,
    this.onTap,
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final double radius = 12.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: IMAGE_BACKGROUND_COLOR,
        ),

        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[

            Positioned.fill(
              child: Hero(
                tag: this.heroTag ?? UniqueKey().toString(),
                child: Image(
                    fit: BoxFit.fill,
                    image: AdvancedNetworkImage(
                      imageUrl,
                      useDiskCache: true,
                      retryLimit: 4,
                    ),
                ),
              ),
            ),

            Positioned.fill(
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onTap,
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}