import 'dart:ui';

import 'package:anime_app/ui/theme/ColorValues.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

typedef OnTap = void Function();

class ItemView extends StatelessWidget {
  final String imageUrl;
  final Widget child;
  final OnTap onTap;
  final double width, height;
  final String imageHeroTag;
  final double borderRadius;
  final Color backgroundColor;
  final String tooltip;

  const ItemView({
    @required this.width,
    @required this.height,
    this.tooltip,
    Key key,
    this.imageUrl,
    this.onTap,
    this.backgroundColor,
    this.child,
    this.imageHeroTag,
    this.borderRadius = 12.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final stack = Stack(
          fit: StackFit.expand,
          children: <Widget>[

            (imageUrl == null)
                ?
                  Align(
                   alignment: Alignment.center,
                   child: child,
                  )
                :

            Positioned.fill(
              child: Hero(
                tag: this.imageHeroTag ?? UniqueKey().toString(),
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
        );

    final containerChild = (tooltip == null) ? stack :
      Tooltip(
        message: tooltip,
        child: stack,
      );    
    return ClipRRect(
      borderRadius: BorderRadius.circular(this.borderRadius ?? .0),
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor ?? secondaryColor,
        ),

        child: containerChild,
      ),
    );
  }
  
}