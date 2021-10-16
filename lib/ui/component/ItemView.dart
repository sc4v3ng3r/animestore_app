import 'dart:ui';
import 'package:anime_app/ui/theme/ColorValues.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

typedef OnTap = void Function();

class ItemView extends StatelessWidget {
  final String? imageUrl;
  final Widget? child;
  final OnTap? onTap;
  final double width, height;
  final String? imageHeroTag;
  final double borderRadius;
  final Color? backgroundColor;
  final String? tooltip;

  const ItemView({
    required this.width,
    required this.height,
    this.child,
    this.tooltip,
    Key? key,
    this.imageUrl,
    this.onTap,
    this.backgroundColor,
    this.imageHeroTag,
    this.borderRadius = 12.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stack = Stack(
      fit: StackFit.expand,
      children: <Widget>[
        (imageUrl == null)
            ? Align(
                alignment: Alignment.center,
                child: child ?? SizedBox(),
              )
            : Positioned.fill(
                child: Hero(
                  tag: this.imageHeroTag ?? UniqueKey().toString(),
                  child: Image(
                    fit: BoxFit.fill,
                    image: CachedNetworkImageProvider(imageUrl!),
                  ),
                ),
              ),
        Positioned.fill(
          child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
              )),
        ),
      ],
    );

    final containerChild = (tooltip == null)
        ? stack
        : Tooltip(
            message: tooltip!,
            child: stack,
          );
    return ClipRRect(
      borderRadius: BorderRadius.circular(this.borderRadius),
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
