import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

class EpisodeItemView extends StatelessWidget {

  final String title;
  final String imageUrl;
  final VoidCallback onTap;
  final double width, height;
  final double borderRadius;
  final double fontSize;
  final Color fontColor;
  final Color backgroundColor;

  const EpisodeItemView({Key key,
    this.title,
    this.width,
    this.height,
    this.fontColor,
    this.backgroundColor,
    this.fontSize,
    this.borderRadius = 12.0,
    this.imageUrl, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(this.borderRadius ?? .0),
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: width,
        height: height + (fontSize ?? 14),
        color: backgroundColor ?? Colors.transparent,

        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(this.borderRadius ?? .0),
              clipBehavior: Clip.antiAlias,
              child: Container(
                width: width,
                height: height * .80,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Positioned.fill(
                      child:  Image(
                        fit: BoxFit.fill,
                        image: AdvancedNetworkImage(
                          imageUrl,
                          useDiskCache: true,
                          retryLimit: 4,
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.play_circle_outline,
                        size: height / 2,
                        color: Colors.grey[300].withOpacity(.7),
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
            ),

            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 6,right: 6,  top: 6),
                  child: Text(title, maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: fontSize ?? 14,
                      color: fontColor ?? Colors.black,
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
