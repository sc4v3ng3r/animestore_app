import 'package:flutter/material.dart';

class SliverGridItemView extends StatelessWidget {
  final EdgeInsets padding;
  final SliverChildBuilderDelegate delegate;
  final int crossAxisCount;
  final double childAspectRatio, mainAxisSpacing, crossAxisSpacing;

  const SliverGridItemView({Key key,
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    @required this.delegate,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 8.0,
    this.crossAxisSpacing = 6.0,
    this.childAspectRatio}
    ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 6.0,
            childAspectRatio: childAspectRatio ?? 1.0 ),
            delegate: delegate,
      ),
    );
  }
}
